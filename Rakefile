#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

RssReader::Application.load_tasks
namespace :feeds do
  task :scrape => :environment do
    Feed.all.each do |t|
      t.scrape
    end
  end

  task :clean => :environment do
    Feed.all.each do |t|
      t.clean
    end
  end

  task :scrape_and_clean => [:scrape, :clean]

end

