module Nard::Rails::DatetimeHelper

  def date_ja_normal( date )
    "#{ date.year }年#{ date.month }月#{ date.day }日"
  end

end
