#expose all active_support tools for whole project
require 'active_support/all'

Dir[File.dirname(__FILE__) + '/app/**/*.rb'].reverse.each {|file| require file }

if ENV['APP_ENVIRONMENT_NAME'].eql?('development')
  require 'byebug'
end

Application.new.run
