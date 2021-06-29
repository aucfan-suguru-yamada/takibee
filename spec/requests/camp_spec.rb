require 'rails_helper'

RSpec.describe 'Camps', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/camp/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/camp/new'
      expect(response).to have_http_status(:success)
    end
  end
end
