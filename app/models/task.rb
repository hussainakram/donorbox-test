# frozen_string_literal: true
class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :status, presence: true

  enum status: [:open, :work_in_progress, :closed]

  after_create :add_tag_on_active_compaign, if: :first_task?

  def add_tag_on_active_compaign
    # TODO: replace perform_now with perform_later
    AddContactTagJob.perform_now(user_id: user.id, tag_id: 1)
  end

  private

  def first_task?
    user.tasks.one?
  end
end
