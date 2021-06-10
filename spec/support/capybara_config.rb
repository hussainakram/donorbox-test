# frozen_string_literal: true

Capybara.register_driver(:selenium_chrome_headless) do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    "goog:chromeOptions" => { args: ["headless", "disable-gpu", "no-sandbox", "remote-debugging-port=9222",
                                     "disable-dev-shm-usage"] }
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
end
