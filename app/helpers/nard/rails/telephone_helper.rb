module Nard::Rails::TelephoneHelper

  # @!group Regexp

  def tel_regexp
    /\A(?:0\d{1}-?\d{4}|0\d{2}-?\d{3}|0\d{3}-?\d{2}|0\d{4}-?\d{1}|0\d{2}-?\d{4})-?\d{4}\Z/
    # /\A0\d{1,4}-?\d{1,4}-?\d{4}\Z/
  end

  # @!endgroup

end
