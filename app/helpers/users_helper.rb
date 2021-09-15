module UsersHelper
  def require_signup
    if current_user.email == 'guest_user@example.com'
      redirect_to new_user_path
    end
  end

  def get_radar_chart(user)
    # キャンプ数
    @radar_camp = user.camps.count
    # アイテム数
    @radar_item = user.items.count
    # Likeした数
    @radar_favorite_camp = user.liked_camps.count
    # Likeされた数
    @radar_camp_by_liked = 0
    user_camps = user.camps
    user_camps.each do |camp|
      @radar_camp_by_liked += camp.likes.count
    end
    # キャンプ範囲
    user_camps = @user.camps.includes(:area)
    max_latitude = 0
    min_latitude = 90
    max_longitude = 0
    min_longitude = 180
    user_camps.each do |camp|
      if camp.area.present?
        latitude = split_lat(camp.area.latlng).to_i
        longitude = split_lng(camp.area.latlng).to_i
        max_latitude = latitude if latitude > max_latitude
        max_longitude = longitude if longitude > max_longitude
        min_latitude = latitude if latitude < min_latitude
        min_longitude = longitude if longitude < min_longitude
      end
      @radar_range_of_area = (((max_latitude - min_latitude)**2 + (max_longitude - min_longitude)**2)**0.5)
    end
    @radar_range_of_area = 0 if max_latitude.zero?
  end
end
