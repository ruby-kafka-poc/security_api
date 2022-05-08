# frozen_string_literal: true

class LogoutController < ApplicationController
  # POST /logout
  def create
    # TODO: expire redis tokens
    render json: { message: 'ok' }
  end
end
