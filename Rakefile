# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

TheGospelite::Application.load_tasks
begin require 'vlad'
  Vlad.load
rescue LoadError
  #do nothing
end

