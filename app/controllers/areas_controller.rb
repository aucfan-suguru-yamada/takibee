class AreasController < ApplicationController
  protect_from_forgery
  before_action :set_camp, only: %i[index create destroy]

  def index
  end

  def create
    if Area.create(area_params)
      redirect_to camp_path(@camp)
    else
      render 'index'
    end
  end

  def destroy
    area = @camp.area
    area.destroy!
    redirect_to camp_path(@camp)
  end

  private

  def set_camp
    @camp = Camp.find(params[:camp_id])
  end

  def area_params
    params.permit(:name, :address, :latlng, :camp_id)
  end
end
