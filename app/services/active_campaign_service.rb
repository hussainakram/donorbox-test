# frozen_string_literal: true
include ApiHelpers

class ActiveCampaignService
  def initialize(user)
    @user = user
  end

  def create_contact
    do_request(
      type: "POST",
      endpoint: "/contacts",
      contact: {
        email: @user.email,
        first_name: @user.first_name,
        last_name: @user.last_name,
      }
    )&.dig("contact")
  end

  def subscribe_contact_to_list(list_id)
    do_request(
      type: "POST",
      endpoint: "/contactLists",
      contactList: {
        list: list_id,
        contact: @user.reload.contact_id,
      }
    )
  end

  def update_contact
    do_request(
      type: "POST",
      endpoint: "/contact/sync",
      contact: {
        email: @user.email,
        first_name: @user.first_name,
        last_name: @user.last_name,
      }
    )&.dig("contact")
  end

  def delete_contact
    do_request(
      type: "DELETE",
      endpoint: "/contacts/#{@user.contact_id}"
    )
  end

  def contacts
    do_request(
      type: "GET",
      endpoint: "/contacts"
    )&.dig("contacts")
  end

  def all_tags
    do_request(
      type: "GET",
      endpoint: "/tags"
    )&.dig("tags")
  end

  def contact_tags
    do_request(
      type: "GET",
      endpoint: "/contacts/#{@user.contact_id}/contactTags"
    )&.dig("contactTags")
  end

  def add_tag_to_contact(tag_id)
    do_request(
      type: "POST",
      endpoint: "/contactTags",
      contactTag: {
        contact: @user.contact_id.to_s,
        tag: tag_id,
      }
    )
  end
end
