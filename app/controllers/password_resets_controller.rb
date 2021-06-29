class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.deliver_reset_password_instructions!
    else
      return redirect_to(new_password_reset_path, danger: 'メールアドレスが正しくありません')
    end
    redirect_to(root_path, warning: '再設定用のメールを送信しました')
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    return if @user.present?

    not_authenticated
    nil
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      redirect_to(root_path, warning: 'パスワードを更新しました')
    else
      render action: 'edit'
    end
  end
end
