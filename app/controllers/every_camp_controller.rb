class EveryCampController < ApplicationController
  def index
    @camps = Camp.includes(:area,
                           user: { avatar_attachment: :blob },
                           items: { small_image_attachment: :blob }).with_attached_images.order('created_at DESC').page(params[:page]).without_count
    @like = Like.new
  end
end
