# frozen_string_literal: true
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    respond_to do |format|
      format.json { render(json: { errors: ["Record not Found"] }, status: :not_found) }
      format.html do
        flash[:error] = "Record Not Found"
        redirect_back(fallback_location: root_path)
      end
    end
  end
end
