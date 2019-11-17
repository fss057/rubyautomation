require 'selenium-webdriver'
require 'rspec/expectations'

include RSpec::Matchers

def setup
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--disable-gpu')
  options.add_argument('--remote-debugging-port=9222')
  @driver = Selenium::WebDriver.for :chrome, options: options
end

def teardown
  @driver.quit
end

def run
  setup
  yield
  teardown
end

run do
  @driver.get 'https://www.dogdaysrescue.org/'
  expect(@driver.title).to eql "DogdaysProject"
  @driver.save_screenshot(File.join(Dir.pwd, "headless.png"))
end