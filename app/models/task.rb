# frozen_string_literal: true
class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :status, presence: true

  enum status: [:open, :work_in_progress, :closed]
end
