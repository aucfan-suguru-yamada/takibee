class UserSessionsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    @user = login(params[:email], params[:password], params[:remember])
    if @user
      redirect_to user_every_camp_index_path(@user), flash: { warning: 'ログインしました' }
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, flash: { warning: 'ログアウトしました' }
  end
end
