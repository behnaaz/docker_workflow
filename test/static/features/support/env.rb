require "middleman"
require 'capybara/cucumber'
require 'capybara/poltergeist'
require 'selenium/webdriver'
require 'middleman-cucumber'


Mongoid.load!("config/mongoid.yml")

FactoryGirl.definition_file_paths = %w(factories)
FactoryGirl.find_definitions


Capybara.server_port = 4567
Capybara.app = Middleman::Cucumber.rack_app


Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: true, cookies: true, debug: false, timeout: 60)
end


World(FactoryGirl::Syntax::Methods)

begin
  DatabaseCleaner.strategy = :truncation
rescue NameError
  raise 'You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it.'
end


Before do
  DatabaseCleaner.start
  page.driver.browser.manage.window.resize_to(1024,768) if page.driver.browser.respond_to?(:manage)
end

After do
  DatabaseCleaner.clean
end

Capybara.always_include_port = true
Capybara.javascript_driver = :poltergeist
Capybara.default_selector = :css
Capybara.ignore_hidden_elements = true


