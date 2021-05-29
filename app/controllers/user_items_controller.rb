class UserItemsController < ApplicationController
  def index
    @search_items_form = SearchUserItemForm.new(maker_id: params[:maker_id], user_id: current_user.id)
    @items = @search_items_form.search.with_attached_small_image.includes(:maker)
  end

  def destroy
    @item_ids = params[:item_ids]
    @item_ids.each do |item_id|
      UserItem.find_by(user_id: current_user.id, item_id:item_id).delete
    end
    @items = current_user.items
  end
end
