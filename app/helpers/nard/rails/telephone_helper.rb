module Nard::Rails::TelephoneHelper

  # @!group Regexp

  def tel_regexp( area_code: true )
    if area_code == true
      /\A(?:(?:0\d{1}-?\d{4}|0\d{2}-?\d{3}|0\d{3}-?\d{2}|0\d{4}-?\d{1}|0\d{2}-?\d{4})-?\d{4}|0120-?(?:\d-?){5}\d)\Z/
      # /\A0\d{1,4}-?\d{1,4}-?\d{4}\Z/
    else
      /\A(?:(?:(?:0\d{1}-?)?\d{4}|(?:0\d{2}-?)?\d{3}|(?:0\d{3}-?)?\d{2}|(?:0\d{4}-?)?\d{1}|0\d{2}-?\d{4})-?\d{4}|0120-?(?:\d-?){5}\d)\Z/
    end
  end

  # @!endgroup

end
