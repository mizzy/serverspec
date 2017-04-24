require "bundler/gem_tasks"
begin
  require "rspec/core/rake_task"
  require "octorelease"
rescue LoadError
end

if defined?(RSpec)
  task :default => 'spec:all'
  task :spec => 'spec:all'

  namespace :spec do
    task :all => [ 'spec:type:all', 'spec:helper' ]

    namespace :type do
      oses = Dir.glob('spec/type/*').map {|d| File.basename(d)}

      task :all => oses.map {|os| "spec:type:#{os}" }

      oses.each do |os|
        RSpec::Core::RakeTask.new(os.to_sym) do |t|
          t.pattern = "spec/type/#{os}/*_spec.rb"
        end
      end
    end

    RSpec::Core::RakeTask.new(:helper) do |t|
        t.pattern = "spec/helper/*_spec.rb"
    end
  end
end
