class SerchUserItemsController < ApplicationController

  def index
    if params[:keyword]
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
      render 'index'
    end
  end
end
