require "bundler/gem_tasks"
begin
  require "rspec/core/rake_task"
  require "octorelease"
rescue LoadError
end

if defined?(RSpec)
  task :spec => 'spec:all'

  namespace :spec do
    oses = %w( darwin debian gentoo plamo redhat redhat7 aix solaris solaris10 solaris11 smartos windows freebsd freebsd10 arch fedora ubuntu nixos)
    backends = %w( exec ssh cmd winrm powershell )

    task :all => [ oses.map {|os| "spec:#{os}" }, backends, :helper, :unit ].flatten

    oses.each do |os|
      RSpec::Core::RakeTask.new(os.to_sym) do |t|
        t.pattern = "spec/#{os}/*_spec.rb"
      end
    end

    backends.each do |backend|
      RSpec::Core::RakeTask.new(backend) do |t|
        t.pattern = "spec/backend/#{backend.to_s}/*_spec.rb"
      end
    end

    RSpec::Core::RakeTask.new(:helper) do |t|
      t.pattern = "spec/helper/*_spec.rb"
    end

    RSpec::Core::RakeTask.new(:unit) do |t|
      t.pattern = "spec/unit/*_spec.rb"
    end
  end
end
