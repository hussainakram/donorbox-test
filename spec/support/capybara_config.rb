# frozen_string_literal: true
Capybara.register_driver(:chrome_headless) do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    'goog:chromeOptions': {
      args: ["no-sandbox", "headless", "disable-gpu"],
    }
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
end

# Ensure Log directory exists
%x(mkdir -p tmp/selenium_logs)

Capybara.register_driver(:chrome) do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    'goog:chromeOptions': { args: ["start-maximized"] }
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities,
    driver_opts: {
      log_path: "./tmp/selenium_logs/selenium-#{Time.now.to_i}.log",
      verbose: true,
    }
  )
end
