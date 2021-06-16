class ItemsController < ApplicationController
  before_action :already_have?, only: %i[create]
  require 'open-uri'

  def index
    @items = Item.includes(:maker).with_attached_small_image
  end

  def create

    io = URI.open(params[:image_url])

    params[:maker_name] = '-' unless params[:maker_name].present?
    if Maker.find_by(name: params[:maker_name])
      maker = Maker.find_by(name: params[:maker_name])
    else
      maker = Maker.create(name: params[:maker_name])
    end

    if Item.find_by(name: params[:name])
      current_user.items << Item.find_by(name: params[:name])
      redirect_to user_items_path, flash: {warning: "#{params[:name][0..20]}...を追加しました"}

    elsif current_user.items.create(name: params[:name], maker_id: maker.id, product_url: params[:product_url])
      current_user.items.last.small_image.attach(io: io, filename: "#{current_user.id}")

      redirect_to user_items_path, flash: {warning: "#{params[:name][0..20]}...を追加しました"}
    else
      render 'index'
    end
  end

  def destroy
    Item.find_by(params[:id]).destroy
    redirect_to items_path
  end

  private

  def create_params
    params.permit(:name, :maker_name)
  end

  def already_have?
    if current_user.items.find_by(name: params[:name])
      flash.now[:warning] = "#{params[:name][0..20]}...はすでに登録されています。"
      render 'search_user_items/index'
    end
  end
end
