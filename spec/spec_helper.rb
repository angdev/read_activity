require "simplecov"
SimpleCov.start

require "active_record"
require "database_cleaner"
require "factory_girl"
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

require "read_activity"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
require_relative "schema.rb"
require_relative "models.rb"
require "generators/read_activity/templates/create_read_activity_marks"
CreateReadActivityMarks.migrate(:up)

FactoryGirl.find_definitions

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.order = :random
end