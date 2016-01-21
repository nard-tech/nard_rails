module Nard::Rails::WdayHelper

  WDAYS_JA_SHORT = [ '日', '月', '火', '水', '木', '金', '土' ]

  # @!group 曜日

  def wday_ja_short( date )
    WDAYS_JA_SHORT[ date.wday ]
  end

  def wday_ja( date )
    "#{ wday_ja_short( date ) }曜"
  end

  alias :wday_ja_normal :wday_ja

  def wday_ja_long( date )
    "#{ wday_ja_short( date ) }曜日"
  end

  def wday_class( date )
    if holiday?( date )
      'holiday'
    else
      date.strftime( "%A" ).downcase
    end
  end

  # @!endgroup

end
