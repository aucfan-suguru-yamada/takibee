class UserItemsController < ApplicationController
  include MakerHelper
  def index
    add_maker_name_to_array
    @items = if params[:id].present?
               current_user.items.by_maker(params[:id])
             else
               current_user.items
             end
  end

  def destroy
    @item_ids = params[:item_ids]
    @item_ids.each do |item_id|
      UserItem.find_by(user_id: current_user.id, item_id: item_id).delete
    end
    @items = current_user.items
  end

  private

    def add_maker_name_to_array
      @items = current_user.items.includes(:maker).with_attached_small_image
      temp_array = []
      @maker_name_array = []
      @items.each do |item|
        temp_array << translate_maker_name(item.maker.name)
        temp_array << item.maker.id
        @maker_name_array << temp_array
        temp_array = []
      end
      @maker_name_array.uniq!
    end
end
