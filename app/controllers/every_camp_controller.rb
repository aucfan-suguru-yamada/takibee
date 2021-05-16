class EveryCampController < ApplicationController
  def index
    @camps = Camp.all
    @like = Like.new
  end
end
