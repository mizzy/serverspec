require "bundler/gem_tasks"
require 'rspec/core/rake_task'

task :spec => 'spec:all'

namespace :spec do
  oses = %w( darwin debian gentoo redhat solaris )

  task :all => [ oses.map {|os| "spec:#{os}" }, :helpers, :exec, :ssh ].flatten

  oses.each do |os|
    RSpec::Core::RakeTask.new(os.to_sym) do |t|
      t.pattern = "spec/#{os}/*_spec.rb"
    end
  end

  RSpec::Core::RakeTask.new(:helpers) do |t|
    t.pattern = "spec/helpers/*_spec.rb"
  end

  RSpec::Core::RakeTask.new(:exec) do |t|
    t.pattern = "spec/backend/exec/*_spec.rb"
  end

  RSpec::Core::RakeTask.new(:ssh) do |t|
    t.pattern = "spec/backend/ssh/*_spec.rb"
  end
end
