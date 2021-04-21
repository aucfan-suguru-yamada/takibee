class ItemsController < ApplicationController

  def index
    if params[:keyword]
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
      render 'index'
    end
  end

  def create
    if current_user.items.create(create_params)
      redirect_to user_items_path
    else
      render 'index'
    end
  end

  private

  def create_params
    params.permit(:name)
  end

end
