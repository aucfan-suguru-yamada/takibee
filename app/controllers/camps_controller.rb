class CampsController < ApplicationController
  def index
    @camps = current_user.camps.order(:camped_on)
  end

  def new
    @camp = Camp.new
  end

  def show
    @camp = Camp.find(params[:id])
    @items = @camp.items
  end

  def create
    if current_user.camps.create(camp_params)
      redirect_to camps_path
    else
      render 'new'
    end
  end


  private

  def camp_params
    params.require(:camp).permit(:title, :camped_on, :number_of_people, :note, images:[])
  end
end
