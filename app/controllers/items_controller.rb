class ItemsController < ApplicationController
  require 'open-uri'

  def index
    @items = Item.all
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
      current_user.items << Item.find_by(name: params[:name])
      redirect_to search_user_items_path, flash: {warning: "#{params[:name][0..20]}...を追加しました"}

    elsif current_user.items.create(name: params[:name], maker_id: maker.id)
      current_user.items.last.small_image.attach(io: io, filename: "#{current_user.id}")

      redirect_to search_user_items_path, flash: {warning: "#{params[:name][0..20]}...を追加しました"}
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
end
