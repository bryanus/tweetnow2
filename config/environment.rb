# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'
require 'twitter'

require 'oauth'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')

Twitter.configure do |config|
  
end
ENV['TWITTER_KEY'] = "M7f0MLXCdFK2ShtQNI0w"
ENV['TWITTER_SECRET'] = "t9aHYeWC0QK76v40s5YZP6qFmWAah7S351SgAuPpvQ"

Twitter.configure do |config|
  # if Sinatra::Application.development?
  #   config.consumer_key = "M7f0MLXCdFK2ShtQNI0w"
  #   config.consumer_secret = "t9aHYeWC0QK76v40s5YZP6qFmWAah7S351SgAuPpvQ"
  # elsif Sinatra::Application.production?
    config.consumer_key = ENV['TWITTER_KEY']
    config.consumer_secret = ENV['TWITTER_SECRET']
  # end
end

puts Sinatra::Application.environment
puts Sinatra::Application.test?
puts Sinatra::Application.development?
puts Sinatra::Application.production?