class SearchUserItemsController < ApplicationController
  include UsersHelper
  before_action :require_signup, only: %i[index]

  def index

    if params[:keyword].present?
      # @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword], tagId: '1001908')
      @items = RakutenWebService::Ichiba::Product.search(keyword: params[:keyword])
      @keyword = params[:keyword]
      render 'index'
    end
  end
end
