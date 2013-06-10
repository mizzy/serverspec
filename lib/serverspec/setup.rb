require 'fileutils'

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

      @backend_type = [ 'Ssh', 'Exec' ][num]
      if @backend_type == 'Ssh'
        print "Vagrant instance y/n: "
        @vagrant = gets.chomp
        if @vagrant =~ (/(true|t|yes|y|1)$/i)
          @vagrant = true
        else
          @vagrant = false
        end
        @vagrant ? print("Input vagrant instance name: ") : print("Input target host name: ")
        @hostname = gets.chomp
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
      content = <<-EOF
require 'serverspec'
require 'pathname'
### include requirements ###

### include backend helper ###
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  if ENV['ASK_SUDO_PASSWORD']
    require 'highline/import'
    c.sudo_password = ask("Enter sudo password: ") { |q| q.echo = false }
  else
    c.sudo_password = ENV['SUDO_PASSWORD']
  end
  ### include backend conf ###
end
EOF

        if not @backend_type.nil?
          content.gsub!(/### include backend helper ###/, "include Serverspec::Helper::#{@backend_type}")
          case @backend_type
            when 'Ssh'
              content.gsub!(/### include requirements ###/, "require 'net/ssh'")
              content.gsub!(/### include backend conf ###/, "c.before :all do
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
      ### include vagrant conf ###
      c.ssh   = Net::SSH.start(c.host, user, options)
    end
  end")
            if @vagrant
              content.gsub!(/### include vagrant conf ###/,"
      config = `vagrant ssh-config --host \#{host}`
      if config != ''
        config.each_line do |line|
          if match = /HostName (.*)/.match(line)
            c.host = match[1]
          elsif  match = /User (.*)/.match(line)
            user = match[1]
          elsif match = /IdentityFile (.*)/.match(line)
            options[:keys] =  [match[1].gsub(/\"/,'')]
          elsif match = /Port (.*)/.match(line)
            options[:port] = match[1]
          end
        end
      end
    ")
            else
              content.gsub!(/### include vagrant conf ###/,'')
            end
            when 'Exec'
              content.gsub!(/### include backend conf ###/, "c.before :all do
  end")
            when 'Puppet'
              content.gsub!(/### include requirements ###/, "require 'puppet'\nrequire 'serverspec/backend/puppet'
")
          end
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
