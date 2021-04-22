class ItemsController < ApplicationController
  require 'open-uri'

  def index
    if params[:keyword]
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
      render 'index'
    end
  end

  def create

    io = open(params[:image_url])

    # binding.pry

    if current_user.items.create(create_params)
      #current_user.items.last.small_image.attach(io: File.open(image_path), filename: 'sample.png')
      current_user.items.last.small_image.attach(io: io, filename: "#{current_user.id}")
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
