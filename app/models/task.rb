# frozen_string_literal: true
class Task < ApplicationRecord
  extend DateTimeHelpers

  belongs_to :user

  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :status, presence: true

  enum status: { open: 0, work_in_progress: 1, closed: 2 }

  after_create :add_tag_on_active_campaign, if: :first_task?

  scope :by_user, ->(user) { where(user: user) if user.present? }

  def self.search(search_by:, value:)
    case search_by
    when :title
      where("title ilike :title", title: "%#{value}%")
    when :status
      where(status: statuses[value.to_sym])
    when :created_at
      where(created_at: date_range_of(value))
    else
      []
    end
  end

  def add_tag_on_active_campaign
    # TODO: replace perform_now with perform_later
    AddContactTagJob.perform_now(user_id: user.id, tag_id: 1)
  end

  private

  def first_task?
    user.tasks.one?
  end
end
