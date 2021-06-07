# frozen_string_literal: true
require "rails_helper"

RSpec.describe(User, type: :model) do
  describe "validations" do
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

  describe "associations" do
    it { should have_many(:tasks) }
  end
end
