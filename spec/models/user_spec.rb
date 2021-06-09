# frozen_string_literal: true
require "rails_helper"

RSpec.describe(User, type: :model) do
  describe "validations" do
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

  describe "associations" do
    let!(:user) { create(:user) }
    let!(:tasks) { create_list(:task, 5, user: user) }

    it { should have_many(:tasks) }

    it "destroys dependent tasks" do
      user.destroy!

      expect(user.tasks.count).to(eq(0))
    end
  end
end
