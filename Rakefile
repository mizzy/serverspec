require "bundler/gem_tasks"
begin
  require "rspec/core/rake_task"
  require "octorelease"
rescue LoadError
end

if defined?(RSpec)
  RSpec::Core::RakeTask.new('spec') do |t|
    t.pattern = 'spec/**/*_spec.rb'
  end
end
