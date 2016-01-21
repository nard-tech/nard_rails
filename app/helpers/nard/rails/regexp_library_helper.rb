module Nard::Rails::RegexpLibraryHelper

  # @!group Regexp

  def num_ary_regexp
    /\A *\[ *(?:\d+ *(?:\, *\d+ *)*)?\] *\Z/
  end

  # @!endgroup

end
