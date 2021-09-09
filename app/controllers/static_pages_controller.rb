class StaticPagesController < ApplicationController
  skip_before_action :require_login
  def top
    @camps = Camp.includes(:area,
                            user: { avatar_attachment: :blob },
                            items: { small_image_attachment: :blob }).with_attached_images.order('created_at DESC').page(params[:page]).per(10).without_count
    @like = Like.new
  end

  def terms; end

  def privacy_policy; end
end
