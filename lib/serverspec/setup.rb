require 'fileutils'

module Serverspec
  class Setup
    def self.run
      %w( spec spec/www.example.jp ).each { |dir| safe_mkdir(dir) }
      safe_create_spec
      safe_create_spec_helper
      safe_create_rakefile
    end

    def self.safe_create_spec
            content = <<-EOF
require 'spec_helper'

describe 'httpd', :os => :redhat do
  it { should be_installed }
  it { should be_enabled   }
  it { should be_running   }
end

describe 'port 80', :os => :redhat do
  it { should be_listening }
end

describe '/etc/httpd/conf/httpd.conf', :os => :redhat do
  it { should be_file }
  it { should contain "ServerName www.example.jp" }
end
EOF

      if File.exists? 'spec/www.example.jp/httpd_spec.rb'
        old_content = File.read('spec/www.example.jp/httpd_spec.rb')
        if old_content != content
          $stderr.puts "!! spec/www.example.jp/httpd_spec.rb already exists and differs from template"
        end
      else
        File.open('spec/www.example.jp/httpd_spec.rb', 'w') do |f|
          f.puts content
        end
        puts ' + spec/www.example.jp/httpd_spec.rb'
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

RSpec.configure do |c|
  c.before do
    c.host = File.basename(Pathname.new(example.metadata[:location]).dirname)
  end
end
EOF
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
