class UserItemsController < ApplicationController
  def index
    @items = current_user.items

    # binding.pry

  end


end
