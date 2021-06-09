class CampsController < ApplicationController
  include UsersHelper
  before_action :require_signup, only: %i[new]
  def index
    @camps = current_user.camps.includes(:area).with_attached_images.order("camped_on DESC")
  end

  def new
    @camp = Camp.new
  end

  def show
    #@camp = Camp.find(params[:id])
    @camp = Camp.with_attached_images.find(params[:id])
    @items = @camp.items.includes(:maker).with_attached_small_image
  end

  def edit
    @camp = Camp.with_attached_images.find(params[:id])
    if current_user == @camp.user
    else
      redirect_to camps_path
    end
  end

  def create
    @camp = current_user.camps.new(camp_params)
      if @camp.save
        redirect_to camps_path
      else
        render 'new'
      end
  end

  def update
    @camp = Camp.find(params[:id])
    if params[:image_id].present?
      image = @camp.images&.find(params[:image_id])
      image.purge
      @items = @camp.items
      redirect_to edit_camp_path(@camp)
    else
      @camp.update(camp_params)
      redirect_to camp_path(@camp)
    end
  end

  def destroy
    @camp = Camp.find(params[:id])
    @camp.destroy!
    redirect_to camps_path
  end

  private

  def camp_params
    params.require(:camp).permit(:title, :camped_on, :number_of_people, :note, images:[])
  end
end
