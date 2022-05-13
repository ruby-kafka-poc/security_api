# frozen_string_literal: true

require 'rails_helper'
require 'requests_helper'

RSpec.describe '/users', type: :request do
  let(:valid_attributes) do
    {
      email: Faker::Internet.email,
      password: Faker::Lorem.sentence
    }
  end
  let(:invalid_attributes) { { email: 'wrong.com' } }
  let(:token) { JWT.encode({ user_id: user.id }, SECRETS['jwt_key']) }
  let(:headers) { { Authorization: "Bearer #{token}" } }
  let(:user) { FactoryBot.create(:user) }

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new User' do
        expect do
          post users_url,
               params: { user: valid_attributes }, as: :json
        end.to change(User, :count).by(1)
      end

      it 'renders a JSON response with the new user' do
        post users_url,
             params: { user: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new User' do
        expect do
          post users_url,
               params: { user: invalid_attributes }, as: :json
        end.to change(User, :count).by(0)
      end

      it 'renders a JSON response with errors for the new user' do
        post users_url,
             params: { user: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          password: Faker::Lorem.sentence
        }
      end

      it 'updates the requested user' do
        patch user_url(user),
              params: { user: new_attributes }, headers: headers, as: :json
        expect(user.reload.password_digest).not_to be_empty
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the user' do
        patch user_url(user),
              params: { user: invalid_attributes }, headers: headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid jwt' do
      let(:token) { 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.e30.Et9HFtf9R3GEMA0IICOfFMVXY7kkTX1wr4qCyhIf58U' }
      it 'renders a JSON response with errors for the user' do
        patch user_url(user),
              params: { user: invalid_attributes }, headers: headers, as: :json
        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested user' do
      delete user_url(user.id), headers: headers, as: :json
      expect(User.all.count).to eq(0)
    end
  end
end
