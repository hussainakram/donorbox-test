# frozen_string_literal: true
require "rails_helper"

describe ActiveCampaignService do
  context "manage contacts" do
    let!(:user) { double(:user) }
    let!(:real_user) { create(:user, email: "test_2@test.com") }
    let!(:service_object) { instance_double(ActiveCampaignService) }

    it "initializes class object with user" do
      allow(ActiveCampaignService).to(receive(:new).with(user))
    end

    # TODO: this spec not running on Github CI
    # it "#create_contact" do
    #   VCR.use_cassette("create_contact") do
    #     service_object = described_class.new(real_user)

    #     result = service_object.create_contact

    #     allow(service_object).to(receive(:create_contact))
    #     expect(result.is_a?(Hash)).to(be_truthy)
    #     expect(result["email"]).to(eq(real_user.email))
    #     expect(result["firstName"]).to(eq(real_user.first_name))
    #     expect(result["lastName"]).to(eq(real_user.last_name))
    #   end
    # end

    it "#subscribe_contact_to_list" do
      allow(service_object).to(receive(:subscribe_contact_to_list).with(1))
    end

    it "#update_contact" do
      allow(service_object).to(receive(:update_contact))
    end

    it "#delete_contact" do
      allow(service_object).to(receive(:delete_contact))
    end

    it "#contacts" do
      allow(service_object).to(receive(:contacts))
    end

    it "#all_tags" do
      allow(service_object).to(receive(:all_tags))
    end

    it "#contact_tags" do
      allow(service_object).to(receive(:contact_tags))
    end

    it "#add_tag_to_contact" do
      allow(service_object).to(receive(:add_tag_to_contact).with(1))
    end
  end
end
