# require "bundler/gem_tasks"
# require "rspec/core/rake_task"

# RSpec::Core::RakeTask.new(:spec)

# task :default => :spec


#!/usr/bin/env rake

require 'bundler'
require 'rake'
require 'yaml'
require 'rspec/core/rake_task'

Bundler::GemHelper.install_tasks
RSpec::Core::RakeTask.new('spec')

# default task is running rspec tests
task :default => :spec
