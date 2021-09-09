class StaticPagesController < ApplicationController
  skip_before_action :require_login
  def top
    @camps = Camp.includes(:area,
                            user: { avatar_attachment: :blob }).with_attached_images.order('created_at DESC').page(params[:page]).per(10).without_count
    @like = Like.new
    @items = Item.joins(:user_items).group(:item_id).order('count(user_id) desc').includes([:maker]).with_attached_small_image.page(params[:page]).per(10)
  end

  def terms; end

  def privacy_policy; end
end
