require 'rails_helper'

RSpec.describe 'CampItems', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/camp_items/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/camp_items/new'
      expect(response).to have_http_status(:success)
    end
  end
end
