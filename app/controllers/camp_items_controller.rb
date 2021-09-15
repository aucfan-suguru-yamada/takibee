class CampItemsController < ApplicationController
  before_action :set_camp, only: %i[index destroy search_items my_items add_my_items]

  def new; end

  def index; end

  def search_items
    return unless params[:keyword]

    @items = RakutenWebService::Ichiba::Product.search(keyword: params[:keyword])
    render 'search_items'
  end

  def my_items
    @items = current_user.items.includes(:maker).with_attached_small_image
  end

  def add_my_items
    @item_ids = params[:item_ids]
    @item_ids.each do |item_id|
      @camp.items << current_user.items.find(item_id)
    end
    redirect_to camp_path(@camp)
  end

  def destroy
    CampItem.find_by(camp_id: params[:camp_id], item_id: params[:item_id]).delete
    redirect_to camp_path(@camp)
  end

  private

    def set_camp
      @camp = Camp.find(params[:camp_id])
    end

    def create_params
      params.permit(:name, :maker_name)
    end
end
