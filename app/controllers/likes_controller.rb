class LikesController < ApplicationController

  def create
    @camp = Camp.find(params[:every_camp_id])
    @like = current_user.likes.create(camp_id: params[:every_camp_id])
  end

  def destroy
    @camp = Camp.find(params[:every_camp_id])
    @like = Like.find_by(camp_id: params[:every_camp_id], user_id: current_user.id)
    @like.destroy
  end
end
