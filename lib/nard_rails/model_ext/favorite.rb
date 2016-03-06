module Nard::Rails::ModelExt::Favorite

  def is_favored?( by: )
    user = by
    favorite( by: user ).present?
  end

  def favorite( by: )
    user = by
    favorites.find_by( user: user )
  end

end
