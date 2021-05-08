module CampHelper
  def split_lat(string)
    string[1..-1].chop.split(",")[0]
  end

  def split_lng(string)
    string[1..-1].chop.split(",")[1]
  end

  def lng()
  end
end
