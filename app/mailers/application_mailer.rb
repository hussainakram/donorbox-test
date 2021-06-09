# frozen_string_literal: true
class ApplicationMailer < ActionMailer::Base
  default "Message-ID" => lambda { "<#{SecureRandom.uuid}@#{ENV["HOST"]}>" }
  default from: ENV["SUPPORT_EMAIL"]
  layout "mailer"
end
