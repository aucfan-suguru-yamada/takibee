module ApplicationHelper
  def active_if(*path)
    active_menu?(*path) ? 'active-nav-item' : ''
  end

  def active_menu?(*path)
    path.any? { |c| c == controller_path }
  end

  def before_login_active_if(path, action)
    path == controller_path && action == action_name ? 'active-nav-item' : ''
  end
end
