require 'active_support/all'

Dir[File.dirname(__FILE__) + '/../app/**/*.rb'].reverse.each {|file| require file }

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |file| require file }

RSpec::Expectations.configuration.on_potential_false_positives = :nothing

Config.load_and_set_settings(Config.setting_files(File.join(Dir.pwd, 'config'), ENV['APP_ENVIRONMENT_NAME']))

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end


  config.mock_with :rspec do |mocks|

    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include HttpResponseSpecHelper, scope: :http_response

end
