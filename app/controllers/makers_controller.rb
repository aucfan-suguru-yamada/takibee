class MakersController < ApplicationController
  def index
    if current_user.is_admin_user?
      @makers = Maker.all
    else
      redirect_to user_every_camp_index_path(current_user)
    end
  end

  def new
    @maker = Maker.new
  end

  def create
    @maker = Maker.new(maker_params)
    if @maker.save
      redirect_to makers_path, flash: {success: 'メーカー名を登録しました'}
    else
      flash.now[:danger] = 'メーカー名の登録に失敗しました'
      render :new
    end
  end

  def update
  end

  def destroy
    Maker.find_by(params[:id]).destroy
    redirect_to makers_path
  end

  private

  def maker_params
    params.require(:maker).permit(:name)
  end
end
