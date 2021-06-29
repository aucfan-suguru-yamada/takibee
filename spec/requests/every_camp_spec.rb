require 'rails_helper'

RSpec.describe 'EveryCamps', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/every_camp/index'
      expect(response).to have_http_status(:success)
    end
  end
end
