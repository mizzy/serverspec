require 'fileutils'
require 'erb'

module Serverspec
  class Setup
    def self.run
      prompt = <<-EOF
Select a backend type:

  1) SSH
  2) Exec (local)

Select number: 
EOF
      print prompt.chop
      num = gets.to_i - 1
      puts

      @backend_type = [ 'Ssh', 'Exec' ][num] || 'Exec'
      if @backend_type == 'Ssh'
        print "Vagrant instance y/n: "
        @vagrant = gets.chomp
        if @vagrant =~ (/(true|t|yes|y|1)$/i)
          @vagrant = true
          print "Auto-configure Vagrant from Vagrantfile? y/n: "
          auto_config = gets.chomp
          if auto_config =~ (/(true|t|yes|y|1)$/i)
            auto_vagrant_configuration
          else
            print("Input vagrant instance name: ")
            @hostname = gets.chomp
          end
        else
          @vagrant = false
          print("Input target host name: ")
          @hostname = gets.chomp
        end
      else
        @hostname = 'localhost'
      end
      [ 'spec', "spec/#{@hostname}" ].each { |dir| safe_mkdir(dir) }
      safe_create_spec
      safe_create_spec_helper
      safe_create_rakefile
    end

    def self.safe_create_spec
      content = <<-EOF
require 'spec_helper'

describe package('httpd') do
  it { should be_installed }
end

describe service('httpd') do
  it { should be_enabled   }
  it { should be_running   }
end

describe port(80) do
  it { should be_listening }
end

describe file('/etc/httpd/conf/httpd.conf') do
  it { should be_file }
  it { should contain "ServerName #{@hostname}" }
end
EOF

      if File.exists? "spec/#{@hostname}/httpd_spec.rb"
        old_content = File.read("spec/#{@hostname}/httpd_spec.rb")
        if old_content != content
          $stderr.puts "!! spec/#{@hostname}/httpd_spec.rb already exists and differs from template"
        end
      else
        File.open("spec/#{@hostname}/httpd_spec.rb", 'w') do |f|
          f.puts content
        end
        puts " + spec/#{@hostname}/httpd_spec.rb"
      end
    end

    def self.safe_mkdir(dir)
      if File.exists? dir
        unless File.directory? dir
          $stderr.puts "!! #{dir} already exists and is not a directory"
        end
      else
        FileUtils.mkdir dir
        puts " + #{dir}/"
      end
    end

    def self.safe_create_spec_helper
      requirements = []
      content = ERB.new(DATA.read, nil, '-').result(binding)
      if File.exists? 'spec/spec_helper.rb'
        old_content = File.read('spec/spec_helper.rb')
        if old_content != content
          $stderr.puts "!! spec/spec_helper.rb already exists and differs from template"
        end
      else
        File.open('spec/spec_helper.rb', 'w') do |f|
          f.puts content
        end
        puts ' + spec/spec_helper.rb'
      end
    end

    def self.safe_create_rakefile
      content = <<-'EOF'
require 'rake'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/*/*_spec.rb'
end
EOF
      if File.exists? 'Rakefile'
        old_content = File.read('Rakefile')
        if old_content != content
          $stderr.puts "!! Rakefile already exists and differs from template"
        end
      else
        File.open('Rakefile', 'w') do |f|
          f.puts content
        end
        puts ' + Rakefile'
      end
    end

    def self.find_vagrantfile
      Pathname.new(Dir.pwd).ascend do |dir|
        path = File.expand_path("Vagrantfile", dir)
        return path if File.exists?(path)
      end
      nil
    end

    def self.auto_vagrant_configuration
      if find_vagrantfile
        vagrant_list = `vagrant status`
        list_of_vms = []
        if vagrant_list != ''
          vagrant_list.each_line do |line|
            if match = /([a-z]+[\s]+)(created|not created|poweroff|running|saved)[\s](\(virtualbox\)|\(vmware\))/.match(line)
              list_of_vms << match[1].strip!
            end
          end
          if list_of_vms.length == 1
            @hostname = list_of_vms[0]
          else
            list_of_vms.each_with_index { |vm, index | puts "#{index}) #{vm}\n" }
            print "Choose a VM from the Vagrantfile: "
            chosen_vm = gets.chomp
            @hostname = list_of_vms[chosen_vm.to_i]
          end
        else
          $stderr.puts "Vagrant status error - Check your Vagrantfile or .vagrant"
          exit 1
        end
      else
        $stderr.puts "Vagrantfile not found in directory!"
        exit 1
      end
    end
  end
end
