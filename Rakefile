require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = 'acts_as_blamable'
    gem.summary = 'Stores the creator and updater of a database record'
    gem.description = 'Automatically set created_by and updated_by fields'
    gem.email = 'philipp.ullmann@create.at'
    gem.homepage = 'http://github.com/create-philipp-ullmann/acts_as_blamable'
    gem.authors = ['Philipp Ullmann']
    gem.add_development_dependency 'rspec', '>= 2.0.0'
    gem.add_development_dependency 'sqlite3-ruby', '>= 1.3.1'
    gem.add_development_dependency 'activerecord', '>= 3.0.0'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: gem install jeweler'
end

desc('Run RSpec')
RSpec::Core::RakeTask.new do |t|
  t.verbose = false
end

task(:default => :spec)
