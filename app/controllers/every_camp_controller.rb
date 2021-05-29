class EveryCampController < ApplicationController
  def index
    @camps = Camp.all.includes(user: { avatar_attachment: :blob }, items: { small_image_attachment: :blob }).with_attached_images
    @like = Like.new
  end
end
