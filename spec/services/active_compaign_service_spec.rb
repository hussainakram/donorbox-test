# frozen_string_literal: true
require "rails_helper"

describe ActiveCompaignService do
  context "manage contacts" do
    let(:user) { double(:user) }
    let(:service_object) { instance_double(ActiveCompaignService) }

    it "initializes class object with user" do
      allow(ActiveCompaignService).to(receive(:new).with(user))
    end

    it "#create_contact" do
      allow(service_object).to(receive(:create_contact))
    end

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
