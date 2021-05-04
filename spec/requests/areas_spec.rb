require 'rails_helper'

RSpec.describe "Areas", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/areas/index"
      expect(response).to have_http_status(:success)
    end
  end

end
