class UserSessionsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to root_path, flash: {success: 'ログインしました'}
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path, flash: {success: 'ログアウトしました'}

  end
end
