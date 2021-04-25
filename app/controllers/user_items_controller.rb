class UserItemsController < ApplicationController
  def index
    @items = current_user.items.uniq
  end

  def destroy
    UserItem.find_by(user_id: current_user.id, item_id:params[:id]).delete
    redirect_to user_items_path
  end
end
