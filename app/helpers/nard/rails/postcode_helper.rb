module Nard::Rails::PostcodeHelper

  # @!group Regexp

  def postcode_regexp
    /\A\d{3}-?\d{4}\Z/
  end

  def link_to_postcode_search_page
    link_to( '郵便番号を調べる' , 'http://www.post.japanpost.jp/zipcode/' , class: [ 'btn' , 'btn-primary' , 'link-to-postcode-search' ] , target: :_blank )
  end

  # @!endgroup

end
