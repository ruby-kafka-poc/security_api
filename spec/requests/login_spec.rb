# frozen_string_literal: true

require 'rails_helper'
require 'requests_helper'

RSpec.describe '/users', type: :request do
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Lorem.sentence }
  let(:valid_attributes) { { email:, password: } }
  let(:invalid_attributes) { { email:, password: 'wroooong' } }
  let!(:user) { FactoryBot.create(:user, email:, password:) }

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'create the jwt' do
        post login_index_path, params: valid_attributes, as: :json
        expect(response.content_type).to match(a_string_including('application/json'))
        jwt = JSON.parse(response.body)['jwt']
        payload = Security.decode("Bearer #{jwt}")
        expect(payload.first['email']).to eq(email)
        expect(payload.first['user_id']).to eq(user.id)
        expect(payload.first['exp'] > Time.now.to_i).to be_truthy
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create the token' do
        post login_index_path, params: invalid_attributes, as: :json
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Invalid username or password')
      end
    end
  end
end
