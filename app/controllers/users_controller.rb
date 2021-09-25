class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_user, only: %i[show update destroy]
  before_action :authenticate_user, only: %i[edit destroy]
  before_action :require_signup, only: %i[edit]
  include UsersHelper
  include CampHelper

  def index
    if current_user.is_admin_user?
      @users = User.with_attached_avatar
    else
      redirect_to user_every_camp_index_path(current_user)
    end
  end

  def show
    @user = User.find(params[:id])
    @camps = @user.camps.includes(:area, items: { small_image_attachment: :blob }).with_attached_images.order('created_at DESC').page(params[:page])
    @items = @user.items.with_attached_small_image.includes(:maker)
    @favorite_camps = @user.liked_camps.includes(:area, user: { avatar_attachment: :blob },
                                                        items: { small_image_attachment: :blob })
                           .with_attached_images.order('created_at DESC')
                           .page(params[:page])
    # レーダーチャートの変数
    # キャンプ数
    @radar_camp = @user.camps.count
    # アイテム数
    @radar_item = @user.items.count
    # Likeした数
    @radar_favorite_camp = @user.liked_camps.count
    # Likeされた数
    @radar_camp_by_liked = @user.get_camp_by_liked
    # キャンプ範囲
    @radar_range_of_area = @user.get_range_of_camparea
    # タブの切り替えajax
    return unless request.xhr?
    case params[:type]
    when 'camp', 'favorite_camp'
      render "#{params[:type]}"
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if @user.avatar.blank?
        @user.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'sample.jpeg')), filename: 'sample.jpeg',
                            content_type: 'image/jpeg')
      end
      # redirect_to login_path, flash: {warning: t('.success')}
      # そのままログインする
      auto_login(@user)
      redirect_to user_every_camp_index_path(@user), flash: { warning: 'ログインしました' }
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      redirect_to edit_user_path(@user), flash: { danger: t('.fail') }
    end
  end

  def destroy
    @user = current_user.destroy!
    redirect_to root_path
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def authenticate_user
      return if current_user == User.find(params[:id])
      redirect_to user_path(current_user)
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    end
end
