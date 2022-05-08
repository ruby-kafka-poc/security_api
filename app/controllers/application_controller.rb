# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorized

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def current_user
    @current_user ||= begin
      payload = Security.decode(auth_header)&.first
      User.find_by(id: payload['user_id']) if payload
    end
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless current_user
  end
end
