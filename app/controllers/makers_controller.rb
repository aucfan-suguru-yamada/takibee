class MakersController < ApplicationController
  def index
    @makers = Maker.all
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
  end

  private

  def maker_params
    params.require(:maker).permit(:name)
  end
end
