require 'factory_girl_rails'
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
	expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
	# Prevents you from mocking or stubbing a method that does not exist on
	# a real object. This is generally recommended, and will default to
	# `true` in RSpec 4.
	mocks.verify_partial_doubles = true
  end

  # config.use_transactional_fixtures = false

  config.before(:suite) do
	DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do |example|
	DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
	DatabaseCleaner.start
  end

  config.after(:each) do
	DatabaseCleaner.clean
  end

  # Factory girl methods
  config.include FactoryGirl::Syntax::Methods
end
