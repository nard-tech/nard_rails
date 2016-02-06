module Nard::Rails::TitleHelper

  def page_title( title = nil )
    ( title.present? ? "#{ title } | #{ ::Settings::Static.app_title }" : ::Settings::Static.app_title )
  end

end
