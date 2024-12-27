# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new :spec

task default: :spec

desc 'Open a pry console with the gem loaded'
task :console do
  exec 'pry -I ./lib -r limit_detectors'
end
