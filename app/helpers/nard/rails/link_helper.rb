module Nard::Rails::LinkHelper

  def display_on_another_window( path , options = nil )
    options ||= {}
    classes = options[:class] || ['btn', 'btn-default', 'btn-xs']
    link_to( '表示' , path, class: classes , title: '別ウィンドウが開きます' , target: :_blank )
  end

  alias :display_on_new_window :display_on_another_window
  alias :open_on_another_window :display_on_another_window
  alias :open_on_new_window :display_on_another_window

  def route_info_path( request )
    "#{ current_host( request ) }/rails/info/routes"
  end

  def current_host( request )
    request[ 'host' ]
  end

  def url_regexp
    /\Ahttps?\:\/{2}/
  end

end
