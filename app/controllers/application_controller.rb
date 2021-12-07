# frozen_string_literal: true

# global controller methods are issued here
class ApplicationController < ActionController::Base
  def render_not_found_error(error_message)
    render json: { code: 404, error_message: error_message }, code: :not_found
  end

  def render_system_error(error_message)
    render json: { code: 500, error_message: error_message }, code: :internal_server_error
  end
end
