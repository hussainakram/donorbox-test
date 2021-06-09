# frozen_string_literal: true
module ApiHelpers
  BASE_URL = ENV["ACTIVE_COMPAIGN_BASE_URL"]
  API_KEY = ENV["ACTIVE_COMPAIGN_API_KEY"]

  def do_request(type:, endpoint:, **body)
    request_payload, http = initialize_request(type, endpoint)
    request_payload.body = body.to_json if body.present?

    response = http.request(request_payload)
    JSON.parse(response.body)
  rescue StandardError => e
    if response.present?
      error_text = response.message
      status = response.code
    else
      error_text = "#{e.class}: #{e.message}"
      status = 500
    end

    { error: error_text, status: status }
  end

  private

  def initialize_request(type, endpoint)
    uri = URI.parse((BASE_URL + endpoint).to_s)
    request = case type
    when "POST"
      Net::HTTP::Post.new(uri.request_uri)
    when "PUT"
      Net::HTTP::Put.new(uri.request_uri)
    when "DELETE"
      Net::HTTP::Delete.new(uri.request_uri)
    else
      Net::HTTP::Get.new(uri.request_uri)
    end

    request["Content-Type"] = "application/json"
    request["Api-Token"] = API_KEY
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    [request, http]
  end
end
