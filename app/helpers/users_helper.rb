module UsersHelper
  def require_signup
    if current_user.email == 'guest_user@example.com'
      redirect_to new_user_path
    end
  end
end
