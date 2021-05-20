class UserItemsController < ApplicationController
  def index
    @search_items_form = SearchUserItemForm.new(maker_id: params[:maker_id], user_id: current_user.id)
    @items = @search_items_form.search
  end

  def destroy
    UserItem.find_by(user_id: current_user.id, item_id:params[:id]).delete
    redirect_to user_items_path
  end
end
