# frozen_string_literal: true
require "rails_helper"

RSpec.describe(ApiHelpers) do
  let(:dummy_class) { Class.new { include ApiHelpers } }

  it "allows #do_request" do
    dummy_instance = dummy_class.new
    allow(dummy_instance).to(receive(:do_request))
  end
end
