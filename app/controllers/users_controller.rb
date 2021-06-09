class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_user, only: %i[ show update destroy ]
  before_action :authenticate_user, only: %i[ edit ]
  include CampHelper

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    @camps = @user.camps.includes(:area, items: { small_image_attachment: :blob }).with_attached_images.order("camped_on DESC").page(params[:page])
    @items = @user.items.with_attached_small_image.includes(:maker)
    @favorite_camps = @user.liked_camps.includes(:area, user: { avatar_attachment: :blob}, items: { small_image_attachment: :blob }).with_attached_images.order("camped_on DESC").page(params[:page])
    #レーダーチャートの変数
    #キャンプ数
    @radar_camp = @user.camps.count
    #アイテム数
    @radar_item = @user.items.count
    #Likeした数
    @radar_favorite_camp = @user.liked_camps.count
    #Likeされた数
    @radar_camp_by_liked = 0
    user_camps = @user.camps
    user_camps.each do |camp|
      @radar_camp_by_liked += camp.likes.count
    end
    #キャンプ地の範囲
    user_camps = @user.camps.includes(:area)
    max_latitude = 0
    min_latitude = 90
    max_longitude = 0
    min_longitude = 180
    user_camps.each do |camp|
      if camp.area.present?
        latitude = split_lat(camp.area.latlng).to_i
        longitude = split_lng(camp.area.latlng).to_i
        max_latitude = latitude if latitude > max_latitude
        max_longitude = longitude if longitude > max_longitude
        min_latitude = latitude if latitude < min_latitude
        min_longitude = longitude if longitude < min_longitude
      end
      @radar_range_of_area = (((max_latitude - min_latitude)**2 + (max_longitude - min_longitude)**2)**0.5)
    end
    @radar_range_of_area = 0 if @radar_range_of_area.nil?
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = current_user
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      @user.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'sample.jpeg')), filename: 'sample.jpeg', content_type: 'image/jpeg') unless @user.avatar.present?
      redirect_to login_path, flash: {warning: t('.success')}
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def update
    @user = User.update(user_params)
    redirect_to user_path(@user)
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def authenticate_user
      if current_user != User.find(params[:id])
        redirect_to user_path(current_user)
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    end
end
