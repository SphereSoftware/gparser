require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "gparser"
require 'dotenv/tasks'
require "json"

RSpec::Core::RakeTask.new(:spec)

desc "Dev env to run exmaple code"
task :run => :dotenv do
  unless ENV['EMAIL']
    puts "provide ENV['EMAIL'] or edit .env file"
    exit
  end

  unless ENV['GKEY']
    puts "provide ENV['GKEY'] or edit .env file"
    exit
  end

   gp = Gparser::Feed.new(ENV['EMAIL'], ENV['GKEY'])
   puts "We are going to parse your email feed, plz be patient that can take a minute or two  👷‍"
   puts JSON.pretty_generate(gp.parse)
end

task :default => :run
