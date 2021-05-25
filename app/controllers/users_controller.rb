class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_user, only: %i[ show edit update destroy ]


  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    @camps = @user.camps
    @items = @user.items
    #レーダーチャートの変数
    @radar_camp = @camps.count
    @radar_item = @user.items.count
    @radar_favolite_camp = @user.liked_camps.count
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
      @user.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'sample.png')), filename: 'sample.png', content_type: 'image/png') unless @user.avatar.present?
      redirect_to login_path, flash: {success: t('.success')}
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

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    end
end
