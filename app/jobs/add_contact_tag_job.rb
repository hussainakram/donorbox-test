# frozen_string_literal: true
class AddContactTagJob < ApplicationJob
  def perform(user_id:, tag_id:)
    user = User.find_by(id: user_id)
    return if user.nil? || user.contact_id.nil?

    service_object = ActiveCampaignService.new(user)
    contact_tags = service_object.contact_tags
    # return if same tag already exists for this contact
    return if contact_tags.any? do |tag|
                tag["id"] = tag_id && tag["contact"] == user.contact_id && tag["tagType"] == "contact"
              end

    service_object.add_tag_to_contact(tag_id)
  end
end
