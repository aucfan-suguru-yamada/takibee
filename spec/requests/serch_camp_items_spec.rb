require 'rails_helper'

RSpec.describe 'SerchCampItems', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/serch_camp_items/index'
      expect(response).to have_http_status(:success)
    end
  end
end
