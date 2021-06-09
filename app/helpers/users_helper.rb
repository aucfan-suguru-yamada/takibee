module UsersHelper
  def require_signup
    if current_user.id == 13
      redirect_to new_user_path
    end
  end
end
