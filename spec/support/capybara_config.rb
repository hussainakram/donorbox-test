# frozen_string_literal: true
Capybara.register_driver(:chrome_headless) do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: ["--headless", "--disable-gpu"] },
    'goog:loggingPrefs': {
      browser: "ALL",
    }
  )

  options = ::Selenium::WebDriver::Chrome::Options.new

  options.add_argument("--headless")
  options.add_argument("--no-sandbox")
  options.add_argument("--remote-debugging-port=9222")

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities,
    options: options
  )
end
