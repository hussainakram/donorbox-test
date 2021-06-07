# frozen_string_literal: true
require "rails_helper"

RSpec.describe(Task, type: :model) do
  describe "validations" do
    let!(:task) { create(:task) }
    it { should validate_uniqueness_of(:title).scoped_to(:user_id) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:status) }
  end

  describe "associations" do
    it { should belong_to(:user) }
  end
end
