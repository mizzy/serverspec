require 'fileutils'

module Serverspec
  class Setup
    def self.run
      prompt = <<-EOF
Select a backend type:

  1) SSH
  2) Exec (local)
  3) Puppet providers (local)

Select number: 
EOF
      print prompt.chop
      num = gets.to_i - 1
      puts

      @backend_type = [ 'Ssh', 'Exec', 'Puppet' ][num]
      if @backend_type == 'Ssh'
        print "Input target host name: "
        @hostname = gets.chomp
      else
        @hostname = 'localhost'
      end

      prompt = <<-EOF

Select OS type of target host:

  1) Red Hat
  2) Debian
  3) Gentoo
  4) Solaris
  5) None

Select number: 
EOF

      print prompt.chop
      num = gets.to_i - 1
      puts

      @os_type = [ 'RedHat', 'Debian', 'Gentoo', 'Solaris', nil ][num]

      [ 'spec', "spec/#{@hostname}" ].each { |dir| safe_mkdir(dir) }
      safe_create_spec
      safe_create_spec_helper
      safe_create_rakefile
    end

    def self.safe_create_spec

      content = <<-EOF
require 'spec_helper'

describe 'httpd' do
  it { should be_installed }
  it { should be_enabled   }
  it { should be_running   }
end

describe 'port 80' do
  it { should be_listening }
end

describe '/etc/httpd/conf/httpd.conf' do
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
      content = <<-EOF
require 'serverspec'
require 'pathname'
### include requirements ###

RSpec.configure do |c|
  ### include backend helper ###
  ### include os helper ###
  ### include backend conf ###
end
EOF

        if not @backend_type.nil?
          content.gsub!(/### include backend helper ###/, "c.include(Serverspec::Helper::#{@backend_type})")
          case @backend_type
            when 'Ssh'
              content.gsub!(/### include requirements ###/, "require 'net/ssh'")
              content.gsub!(/### include backend conf ###/, "c.before do
    host  = File.basename(Pathname.new(example.metadata[:location]).dirname)
    if c.host != host
      c.ssh.close if c.ssh
      c.host  = host
      options = Net::SSH::Config.for(c.host)
      user    = options[:user] || Etc.getlogin
      c.ssh   = Net::SSH.start(c.host, user, options)
    end
  end
")
            when 'Puppet'
              content.gsub!(/### include requirements ###/, "require 'puppet'")
          end
        end
        if not @os_type.nil?
          content.gsub!(/### include os helper ###/, "c.include(Serverspec::Helper::#{@os_type})")
        end

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
  end
end
