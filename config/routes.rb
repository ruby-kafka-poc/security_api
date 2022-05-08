# frozen_string_literal: true

Rails.application.routes.draw do
  resources :login, only: :create
  resources :logout, only: :create
  resources :users, only: %i[create update destroy]
end
