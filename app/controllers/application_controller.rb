class ApplicationController < ActionController::Base
  before_action :require_login # sorceryが作成するメソッド。ログインしてない時not_authenticatedメソッドを発火する
  add_flash_types :success, :info, :warning, :danger
end
