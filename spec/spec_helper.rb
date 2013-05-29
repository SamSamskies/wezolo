ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'draper/test/rspec_integration'
require 'rack_session_access/capybara'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include CapybaraHelpers
  config.include Capybara::DSL
  Capybara.default_driver = :selenium

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.infer_base_class_for_anonymous_controllers = false

  config.order = "random"

  Draper::ViewContext.test_strategy :fast do
    include ApplicationHelper
  end

  config.after(:all, type: :request) { User.index.delete }
end
