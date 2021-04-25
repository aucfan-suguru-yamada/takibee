require 'rails_helper'

RSpec.describe "Makers", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/maker/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/maker/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/maker/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/maker/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/maker/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
