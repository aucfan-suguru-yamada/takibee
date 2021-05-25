class CampItemsController < ApplicationController
  before_action :set_camp, only: %i[index create destroy search_items my_items add_my_items]
  before_action :already_have?, only: %i[create]
  #  before_action :already_have_camp_item?, only: %i[add_my_items]

  def new
  end

  def index
  end

  def search_items
    if params[:keyword]
      @items = RakutenWebService::Ichiba::Product.search(keyword: params[:keyword])
      render 'search_items'
    end
  end

  def my_items
    @items = current_user.items
  end

  def add_my_items
    @item_ids = params[:item_ids]
    @item_ids.each do |item_id|
      @camp.items << current_user.items.find(item_id)
    end
    redirect_to camp_path(@camp)
  end


  def create
    io = open(params[:image_url])
    params[:maker_name] = '-' unless params[:maker_name].present?

    if Maker.find_by(name: params[:maker_name])
      maker = Maker.find_by(name: params[:maker_name])
    else
      maker = Maker.create(name: params[:maker_name])
    end

    if Item.find_by(name: params[:name])
      if current_user.items.find_by(name: params[:name])
        @camp.items << current_user.items.find_by(name: params[:name])
      else
        current_user.items << Item.find_by(name: params[:name])
        @camp.items << Item.find_by(name: params[:name])
      end

    else
      current_user.items.create(name: params[:name], maker_id: maker.id)
      current_user.items.last.small_image.attach(io: io, filename: "#{current_user.id}")
      @camp.items << current_user.items.find_by(name: params[:name])
    end

    redirect_to camp_path(@camp)
  end

  def destroy
    CampItem.find_by(camp_id: params[:camp_id], item_id:params[:item_id]).delete
    redirect_to camp_path(@camp)
  end

  private

  def set_camp
    @camp = Camp.find(params[:camp_id])
  end

  def create_params
    params.permit(:name, :maker_name)
  end

  def already_have?
    if @camp.items.find_by(name: params[:name])
      flash.now[:danger] = "#{params[:name][0..20]}...はすでに登録されています。"
      render 'search_items'
    end
  end

  def already_have_camp_item?
    if @camp.items.find_by(name: params[:name])
      redirect_to camp_my_items_path, flash: {danger: "#{params[:name][0..20]}...はすでに登録されています。"}
    end
  end
end
