module Nard::Rails::DatetimeHelper

  def date_ja( date, year: true, day_name: false, time: false )
    str = "#{ date.month }月#{ date.day }日"
    str = "#{ date.year }年#{ str }" if year
    str += "（#{ l( date, format: :day_name ) }）" if day_name
    if time and date.respond_to?(:hour) and date.respond_to?(:min) and date.respond_to?(:sec)
      str += l( date, format: :only_time_normal )
    end
    str
  end

  def date_short( obj )
    obj.strftime('%m/%d')
  end

end
