# frozen_string_literal: true
class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table(:tasks) do |t|
      t.string(:title)
      t.integer(:status)
      t.references(:user, null: false, foreign_key: true)

      t.timestamps
    end

    add_index(:tasks, :title)
    add_index(:tasks, :status)
    add_index(:tasks, :created_at)
  end
end
