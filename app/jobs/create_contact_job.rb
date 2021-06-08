# frozen_string_literal: true
class CreateContactJob < ApplicationJob
  def perform(user_id)
    user = User.find_by(id: user_id)
    return if user.nil? || user.contact_id.present?

    service_object = ActiveCampaignService.new(user)
    contact = service_object.create_contact

    if contact.present?
      user.update!(contact_id: contact["id"])

      service_object.subscribe_contact_to_list(1)
    end
  end
end
