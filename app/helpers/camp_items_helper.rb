module CampItemsHelper
  def already_owned?(item)
    if @camp.items.find_by(id: item.id)
      '登録済み'
    else
      '未登録'
    end
  end
end
