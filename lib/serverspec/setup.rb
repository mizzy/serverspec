require 'fileutils'
require 'erb'

module Serverspec
  class Setup
    def self.run

      ask_os_type

      if @os_type == 'UN*X'
        ask_unix_backend
      else
        ask_windows_backend
      end

      if @backend_type == 'Ssh'
        print 'Vagrant instance y/n: '
        @vagrant = $stdin.gets.chomp
        if @vagrant =~ (/(true|t|yes|y|1)$/i)
          @vagrant = true
          print 'Auto-configure Vagrant from Vagrantfile? y/n: '
          auto_config = $stdin.gets.chomp
          if auto_config =~ (/(true|t|yes|y|1)$/i)
            auto_vagrant_configuration
          else
            print("Input vagrant instance name: ")
            @hostname = $stdin.gets.chomp
          end
        else
          @vagrant = false
          print("Input target host name: ")
          @hostname = $stdin.gets.chomp
        end
      else
        @hostname = 'localhost'
      end

      ['spec', "spec/#{@hostname}"].each { |dir| safe_mkdir(dir) }
      safe_create_spec
      safe_create_spec_helper
      safe_create_rakefile
    end

    def self.ask_os_type
      prompt = <<-EOF
Select OS type:

  1) UN*X
  2) Windows

Select number: 
EOF

      print prompt.chop
      num = $stdin.gets.to_i - 1
      puts

      @os_type = ['UN*X', 'Windows'][num] || 'UN*X'
    end

    def self.ask_unix_backend
      prompt = <<-EOF
Select a backend type:

  1) SSH
  2) Exec (local)

Select number: 
EOF
      print prompt.chop
      num = $stdin.gets.to_i - 1
      puts

      @backend_type = ['Ssh', 'Exec'][num] || 'Exec'
    end

    def self.ask_windows_backend
      prompt = <<-EOF
Select a backend type:

  1) WinRM
  2) Cmd (local)

Select number: 
EOF
      print prompt.chop
      num = $stdin.gets.to_i - 1
      puts

      @backend_type = ['WinRM', 'Cmd'][num] || 'Exec'
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
  its(:content) { should match /ServerName #{@hostname}/ }
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
      content = ERB.new(spec_helper_template, nil, '-').result(binding)
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

task :default => :spec
      EOF
      if File.exists? 'Rakefile'
        old_content = File.read('Rakefile')
        if old_content != content
          $stderr.puts '!! Rakefile already exists and differs from template'
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
        path = File.expand_path('Vagrantfile', dir)
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
            if match = /([\w-]+[\s]+)(created|not created|poweroff|running|saved)[\s](\(virtualbox\)|\(vmware\))/.match(line)
              list_of_vms << match[1].strip!
            end
          end
          if list_of_vms.length == 1
            @hostname = list_of_vms[0]
          else
            list_of_vms.each_with_index { |vm, index | puts "#{index}) #{vm}\n" }
            print 'Choose a VM from the Vagrantfile: '
            chosen_vm = $stdin.gets.chomp
            @hostname = list_of_vms[chosen_vm.to_i]
          end
        else
          $stderr.puts 'Vagrant status error - Check your Vagrantfile or .vagrant'
          exit 1
        end
      else
        $stderr.puts 'Vagrantfile not found in directory!'
        exit 1
      end
    end

    def self.spec_helper_template
      template = <<-EOF
require 'serverspec'
<% if @os_type == 'UN*X' && @backend_type == 'Ssh' -%>
require 'pathname'
<% end -%>
<% if @backend_type == 'Ssh' -%>
require 'net/ssh'
<% end -%>
<% if @backend_type == 'WinRM' -%>
require 'winrm'
<% end -%>

include SpecInfra::Helper::<%= @backend_type %>
<% if @os_type == 'UN*X' -%>
include SpecInfra::Helper::DetectOS
<% else  -%>
include SpecInfra::Helper::Windows
<% end -%>

<% if @os_type == 'UN*X' -%>
RSpec.configure do |c|
  if ENV['ASK_SUDO_PASSWORD']
    require 'highline/import'
    c.sudo_password = ask("Enter sudo password: ") { |q| q.echo = false }
  else
    c.sudo_password = ENV['SUDO_PASSWORD']
  end
  <%- if @backend_type == 'Ssh' -%>
  c.before :all do
    block = self.class.metadata[:example_group_block]
    if RUBY_VERSION.start_with?('1.8')
      file = block.to_s.match(/.*@(.*):[0-9]+>/)[1]
    else
      file = block.source_location.first
    end
    host  = File.basename(Pathname.new(file).dirname)
    if c.host != host
      c.ssh.close if c.ssh
      c.host  = host
      options = Net::SSH::Config.for(c.host)
      user    = options[:user] || Etc.getlogin
    <%- if @vagrant -%>
      vagrant_up = `vagrant up #{@hostname}`
      config = `vagrant ssh-config #{@hostname}`
      if config != ''
        config.each_line do |line|
          if match = /HostName (.*)/.match(line)
            host = match[1]
          elsif  match = /User (.*)/.match(line)
            user = match[1]
          elsif match = /IdentityFile (.*)/.match(line)
            options[:keys] =  [match[1].gsub(/\"/,'')]
          elsif match = /Port (.*)/.match(line)
            options[:port] = match[1]
          end
        end
      end
    <%- end -%>
      c.ssh   = Net::SSH.start(host, user, options)
    end
  end
  <%- end -%>
end
<% end -%>
<% if @backend_type == 'WinRM'-%>
RSpec.configure do |c|
  user = <username>
  pass = <password>
  endpoint = "http://<hostname>:5985/wsman"

  c.winrm = ::WinRM::WinRMWebService.new(endpoint, :ssl, :user => user, :pass => pass, :basic_auth_only => true)
  c.winrm.set_timeout 300 # 5 minutes max timeout for any operation
end
<% end -%>
EOF
      template
    end
  end
end
