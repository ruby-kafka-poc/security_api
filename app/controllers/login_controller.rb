# frozen_string_literal: true

class LoginController < ApplicationController
  skip_before_action :authorized
  before_action :set_user

  # POST /users
  def create
    Rails.logger.debug params
    if @user&.authenticate(params[:password])
      render json: { jwt: }, status: :created
    else
      render json: { error: 'Invalid username or password' }, status: :unprocessable_entity
    end
  end

  private

  def email
    @email ||= params[:email]
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.where(email:).first
  end

  def jwt
    Security.encode(@user.id, email)
  end
end
