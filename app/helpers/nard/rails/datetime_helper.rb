module Nard::Rails::DatetimeHelper

  def date_ja_normal( date, day_name: false )
    str = "#{ date.year }年#{ date.month }月#{ date.day }日"
    str += "（#{ l( date, format: :day_name ) }）" if day_name
    str
  end

  def date_ja_without_year( date, day_name: false )
    str = "#{ date.month }月#{ date.day }日"
    str += "（#{ l( date, format: :day_name ) }）" if day_name
    str
  end

end
