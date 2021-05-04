class AreasController < ApplicationController
  protect_from_forgery
  before_action :set_camp, only: %i[index create]

  def index
  end

  def create
    if Area.create(area_params)
      redirect_to camp_path(@camp)
    else
      render 'index'
    end
  end

  private

  def set_camp
    @camp = Camp.find(params[:camp_id])
  end

  def area_params
    params.permit(:name, :address, :camp_id)
  end
end
