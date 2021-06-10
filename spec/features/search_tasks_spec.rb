# frozen_string_literal: true
require "rails_helper"

RSpec.describe("Tasks Dashboard", type: :system) do
  let!(:user) { create(:user, :confirmed) }
  let!(:tasks) { create_list(:task, 5, user: user) }

  describe "search" do
    context "by title" do
      it "without text" do
        sign_in_and_visit(tasks_path)

        find(".search-btn").click
        task_rows = find_all(".tasks-table tbody tr")

        expect(task_rows.count).to(eq(tasks.count))
        expect(page).to(have_content(tasks.sample.title))
      end

      it "with valid text" do
        task_to_search = tasks.first
        task_not_to_search = tasks.last
        sign_in_and_visit(tasks_path)

        find(".query-input").set(task_to_search.title)
        find(".search-btn").click

        expect(page).to(have_content(task_to_search.title))
        expect(page).to_not(have_content(task_not_to_search.title))
      end
    end

    context "by status" do
      let!(:closed_task) { create_list(:task, 5, status: :closed, user: user) }
      let!(:in_progress_task) { create_list(:task, 5, status: :work_in_progress, user: user) }

      it "shows status-dropdown when searching by status" do
        sign_in_and_visit(tasks_path)

        select_option(dropdown: ".search-by-dropdown", option: "status")

        expect(page).to(have_selector(".status-dropdown", visible: true))
      end

      it "status = open" do
        sign_in_and_visit(tasks_path)
        select_option(dropdown: ".search-by-dropdown", option: "status")
        select_option(dropdown: ".status-dropdown", option: "open")

        find(".search-btn").click
        sleep(1)
        statuses = find_all(".tasks-table .status").map(&:text)

        expect(statuses.uniq).to(have_content(["open"]))
      end

      it "status = closed" do
        sign_in_and_visit(tasks_path)
        select_option(dropdown: ".search-by-dropdown", option: "status")
        select_option(dropdown: ".status-dropdown", option: "closed")

        find(".search-btn").click
        sleep(1)
        statuses = find_all(".tasks-table .status").map(&:text)

        expect(statuses.uniq).to(have_content(["closed"]))
      end

      it "status = work_in_progress" do
        sign_in_and_visit(tasks_path)
        select_option(dropdown: ".search-by-dropdown", option: "status")
        select_option(dropdown: ".status-dropdown", option: "work_in_progress")

        find(".search-btn").click
        sleep(1)
        statuses = find_all(".tasks-table .status").map(&:text)

        expect(statuses.uniq).to(have_content(["work_in_progress"]))
      end
    end

    context "by created_at" do
      let!(:creared_at_tasks) { create_list(:task, 5, created_at: "10/02/2021", user: user) }

      it "shows date input field when searching by created_at" do
        sign_in_and_visit(tasks_path)

        select_option(dropdown: ".search-by-dropdown", option: "created_at")

        expect(page).to(have_selector(".date-input", visible: true))
      end

      it "valid date" do
        searched_date = "10/02/2021"
        sign_in_and_visit(tasks_path)
        select_option(dropdown: ".search-by-dropdown", option: "created_at")
        find(".date-input").set(searched_date)

        find(".search-btn").click
        created_at_dates = find_all(".tasks-table .created-at").map(&:text)

        expect(created_at_dates.uniq).to(have_content([searched_date]))
      end
    end
  end

  private

  def sign_in_and_visit(path)
    sign_in
    visit(path)
  end

  def sign_in
    visit(root_path)

    fill_in("user[email]", with: user.email)
    fill_in("user[password]", with: user.password)

    click_button("Log in")
  end

  def select_option(dropdown:, option:)
    find("#{dropdown} option[value='#{option}']").click
  end
end
