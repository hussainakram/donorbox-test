# frozen_string_literal: true
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable

  has_many :tasks, dependent: :destroy

  def after_confirmation
    # TODO: replace perform_now with perform_later
    CreateContactJob.perform_now(id)
  end
end
