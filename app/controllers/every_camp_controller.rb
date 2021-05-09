class EveryCampController < ApplicationController
  def index
    @camps = Camp.all
  end
end
