# frozen_string_literal: true
module TasksHelper
  def status_class_name(status)
    case status.to_sym
    when :open
      "bg-yellow-400"
    when :work_in_progress
      "bg-indigo-400"
    when :closed
      "bg-green-400"
    end
  end
end
