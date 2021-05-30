class EveryCampController < ApplicationController
  def index
    @camps = Camp.all.includes(:area,
                              user: { avatar_attachment: :blob },
                              items: { small_image_attachment: :blob },
                              ).with_attached_images.order("camped_on DESC")
    @like = Like.new
  end
end
