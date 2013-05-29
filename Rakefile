require "bundler/gem_tasks"
require 'rspec/core/rake_task'

task :spec => 'spec:all'

namespace :spec do
  oses = %w( darwin debian gentoo redhat solaris )

  task :all => [ oses.map {|os| "spec:#{os}" }, :others].flatten

  oses.each do |os|
    RSpec::Core::RakeTask.new(os.to_sym) do |t|
      t.pattern = "spec/#{os}/*_spec.rb"
    end
  end

  RSpec::Core::RakeTask.new(:others) do |t|
    t.pattern = "spec/{helpers,backend}/*_spec.rb"
  end
end
