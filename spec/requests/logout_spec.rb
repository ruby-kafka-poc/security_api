# frozen_string_literal: true

require 'rails_helper'
require 'requests_helper'

RSpec.describe '/logout', type: :request do
  let(:token) { JWT.encode({ user_id: user.id }, SECRETS['jwt_key']) }
  let(:valid_headers) { { Authorization: "Bearer #{token}" } }
  let(:user) { FactoryBot.create(:user) }

  describe 'POST /create' do
    context 'with jwt' do
      it 'remove authorizations' do
        post logout_index_path, headers: valid_headers, as: :json
        expect(response.content_type).to match(a_string_including('application/json'))
        result = JSON.parse(response.body)['message']
        expect(result).to eq('ok')
      end
    end

    context 'without jwt' do
      it 'return unauthorized' do
        post logout_index_path, as: :json
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['message']).to eq('Please log in')
      end
    end
  end
end
