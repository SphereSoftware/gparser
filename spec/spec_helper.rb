require "bundler/setup"
require "gparser"
require 'dotenv/load'
require "camcorder"
require 'camcorder/rspec'

Camcorder.config.recordings_dir = 'spec/recordings'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
