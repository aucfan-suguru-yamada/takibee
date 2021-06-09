class LikesController < ApplicationController
  def create
    if current_user.is_guest_user?
      redirect_to new_user_path(current_user)
    else
      @camp = Camp.find(params[:every_camp_id])
      @like = current_user.likes.create(camp_id: params[:every_camp_id])
    end
  end

  def destroy
    @camp = Camp.find(params[:every_camp_id])
    @like = Like.find_by(camp_id: params[:every_camp_id], user_id: current_user.id)
    @like.destroy
  end
end
