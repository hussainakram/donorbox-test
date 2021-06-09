# frozen_string_literal: true
class ApplicationMailer < ActionMailer::Base
  default from: "support@donorbox-test.com"
  layout "mailer"
end
