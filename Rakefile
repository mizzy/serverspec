require "bundler/gem_tasks"
require 'rspec/core/rake_task'

task :spec => 'spec:all'

namespace :spec do
  oses = %w( darwin debian gentoo plamo redhat aix solaris solaris10 solaris11 smartos windows freebsd)

  task :all => [ oses.map {|os| "spec:#{os}" }, :exec, :ssh, :cmd, :winrm, :powershell ].flatten

  oses.each do |os|
    RSpec::Core::RakeTask.new(os.to_sym) do |t|
      t.pattern = "spec/#{os}/*_spec.rb"
    end
  end

  [:exec, :ssh, :cmd, :winrm, :powershell].each do |backend|
    RSpec::Core::RakeTask.new(backend) do |t|
      t.pattern = "spec/backend/#{backend.to_s}/*_spec.rb"
    end
  end
end
