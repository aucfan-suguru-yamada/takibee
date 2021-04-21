require 'rails_helper'

RSpec.describe "Items", type: :request do
  describe "GET /serch" do
    it "returns http success" do
      get "/items/serch"
      expect(response).to have_http_status(:success)
    end
  end

end
