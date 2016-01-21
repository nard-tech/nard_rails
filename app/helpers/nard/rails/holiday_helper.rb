module Nard::Rails::HolidayHelper

  # @!group 祝日

  # （日本の）祝日か否かを判定するメソッド
  # @return [Boolean]
  def holiday?( date )
    HolidayJapan.check( Date.new( date.year, date.month, date.day ) )
  end

  # @!endgroup

end
