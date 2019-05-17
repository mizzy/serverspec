require 'pathname'
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

      if @backend_type == 'ssh'
        print 'Vagrant instance y/n: '
        @vagrant = $stdin.gets.chomp
        if @vagrant =~ (/(true|t|yes|y|1)$/i)
          @vagrant = true
          print 'Auto-configure Vagrant from Vagrantfile? y/n: '
          auto_config = $stdin.gets.chomp
          if auto_config =~ (/(true|t|yes|y|1)$/i)
            auto_vagrant_configuration
          else
            print('Input vagrant instance name: ')
            @hostname = $stdin.gets.chomp
          end
        else
          @vagrant = false
          print('Input target host name: ')
          @hostname = $stdin.gets.chomp
        end
      elsif @backend_type == 'winrm'
        print('Input target host name: ')
        @hostname = $stdin.gets.chomp
      else
        @hostname = 'localhost'
      end

      ['spec', "spec/#{@hostname}"].each { |dir| safe_mkdir(dir) }
      safe_create_spec
      safe_create_spec_helper
      safe_create_rakefile
      safe_create_dotrspec
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

      @backend_type = ['ssh', 'exec'][num] || 'exec'
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

      @backend_type = ['winrm', 'cmd'][num] || 'exec'
    end

    def self.safe_create_spec
      content = <<-EOF
require 'spec_helper'

describe package('httpd'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('apache2'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
end

describe service('httpd'), :if => os[:family] == 'redhat' do
  it { should be_enabled }
  it { should be_running }
end

describe service('apache2'), :if => os[:family] == 'ubuntu' do
  it { should be_enabled }
  it { should be_running }
end

describe service('org.apache.httpd'), :if => os[:family] == 'darwin' do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end
EOF

      if File.exists? "spec/#{@hostname}/sample_spec.rb"
        old_content = File.read("spec/#{@hostname}/sample_spec.rb")
        if old_content != content
          $stderr.puts "!! spec/#{@hostname}/sample_spec.rb already exists and differs from template"
        end
      else
        File.open("spec/#{@hostname}/sample_spec.rb", 'w') do |f|
          f.puts content
        end
        puts " + spec/#{@hostname}/sample_spec.rb"
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

task :spec    => 'spec:all'
task :default => :spec

namespace :spec do
  targets = []
  Dir.glob('./spec/*').each do |dir|
    next unless File.directory?(dir)
    target = File.basename(dir)
    target = "_#{target}" if target == "default"
    targets << target
  end

  task :all     => targets
  task :default => :all

  targets.each do |target|
    original_target = target == "_default" ? target[1..-1] : target
    desc "Run serverspec tests to #{original_target}"
    RSpec::Core::RakeTask.new(target.to_sym) do |t|
      ENV['TARGET_HOST'] = original_target
      t.pattern = "spec/#{original_target}/*_spec.rb"
    end
  end
end
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
            if match = /([\w-]+[\s]+)(created|aborted|not created|poweroff|running|saved)[\s](\(virtualbox\)|\(vmware\)|\(vmware_fusion\)|\(libvirt\))/.match(line)
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
      template = <<-'EOF'
require 'serverspec'
<% if @backend_type == 'ssh' -%>
require 'net/ssh'
<% end -%>
<%- if @vagrant -%>
require 'tempfile'
<% end -%>
<% if @backend_type == 'winrm' -%>
require 'winrm'
<% end -%>

set :backend, :<%= @backend_type %>

<% if @os_type == 'UN*X' && @backend_type == 'ssh' -%>
if ENV['ASK_SUDO_PASSWORD']
  begin
    require 'highline/import'
  rescue LoadError
    fail "highline is not available. Try installing it."
  end
  set :sudo_password, ask("Enter sudo password: ") { |q| q.echo = false }
else
  set :sudo_password, ENV['SUDO_PASSWORD']
end

<%- if @backend_type == 'ssh' -%>
host = ENV['TARGET_HOST']

<%- if @vagrant -%>
`vagrant up #{host}`

config = Tempfile.new('', Dir.tmpdir)
config.write(`vagrant ssh-config #{host}`)
config.close

options = Net::SSH::Config.for(host, [config.path])
<%- else -%>
options = Net::SSH::Config.for(host)
<%- end -%>

options[:user] ||= Etc.getlogin

set :host,        options[:host_name] || host
set :ssh_options, options

# Disable sudo
# set :disable_sudo, true
<%- end -%>


# Set environment variables
# set :env, :LANG => 'C', :LC_MESSAGES => 'C'

# Set PATH
# set :path, '/sbin:/usr/local/sbin:$PATH'
<%- end -%>
<% if @backend_type == 'winrm'-%>
user = <username>
pass = <password>
endpoint = "http://#{ENV['TARGET_HOST']}:5985/wsman"

if Gem::Version.new(WinRM::VERSION) < Gem::Version.new('2')
  winrm = ::WinRM::WinRMWebService.new(endpoint, :ssl, :user => user, :pass => pass, :basic_auth_only => true)
  winrm.set_timeout 300 # 5 minutes max timeout for any operation
else
  opts = {
    user: user,
    password: pass,
    endpoint: endpoint,
    operation_timeout: 300,
    no_ssl_peer_verification: false,
  }

  winrm = ::WinRM::Connection.new(opts)
end

Specinfra.configuration.winrm = winrm
<% end -%>
EOF
      template
    end

    def self.safe_create_dotrspec
      content = <<-'EOF'
--color
--format documentation
      EOF
      if File.exists? '.rspec'
        old_content = File.read('.rspec')
        if old_content != content
          $stderr.puts '!! .rspec already exists and differs from template'
        end
      else
        File.open('.rspec', 'w') do |f|
          f.puts content
        end
        puts ' + .rspec'
      end
    end

  end
end
