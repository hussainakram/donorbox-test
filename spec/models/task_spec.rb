# frozen_string_literal: true
require "rails_helper"

RSpec.describe(Task, type: :model) do
  describe "validations" do
    let!(:task) { create(:task) }
    it { should validate_uniqueness_of(:title).scoped_to(:user_id) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:status) }
    it { is_expected.to(define_enum_for(:status).with_values(Task::STATUSES.keys)) }
  end

  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "callbacks" do
    let!(:user) { create(:user) }
    let!(:task_1) { build(:task, user: user) }
    let!(:task_2) { build(:task, user: user) }

    it "triggers add_tag_on_active_campaign on creating first task" do
      expect(task_1).to(receive(:add_tag_on_active_campaign))
      task_1.save!
    end

    it "do not trigger add_tag_on_active_campaign on create for second task" do
      task_1.save!

      expect(task_2).to_not(receive(:add_tag_on_active_campaign))
      task_2.save!
    end
  end
end
