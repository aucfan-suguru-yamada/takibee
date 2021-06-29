class SearchUserItemsController < ApplicationController
  include UsersHelper
  before_action :require_signup, only: %i[index]

  def index
    return if params[:keyword].blank?

    @items = RakutenWebService::Ichiba::Product.search(keyword: params[:keyword])
    @keyword = params[:keyword]
    render 'index'
  end
end
