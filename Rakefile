# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rake/testtask'
require 'rubocop/rake_task'
require 'rubocop'

RSpec::Core::RakeTask.new :spec

desc 'Open a pry console with the gem loaded'
task :console do
  exec 'pry -I ./lib -r limit_detectors'
end

RuboCop::RakeTask.new

task default: %i[spec rubocop]
