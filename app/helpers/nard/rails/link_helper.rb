module Nard::Rails::LinkHelper

  def display_on_another_window( path , options = nil )
    options ||= {}
    classes = options[:class]
    classes ||= ['btn', 'btn-default', 'btn-xs']
    link_to( '表示' , path, class: classes , title: '別ウィンドウが開きます' , target: :_blank )
  end

  alias :display_on_new_window :display_on_another_window
  alias :open_on_another_window :display_on_another_window
  alias :open_on_new_window :display_on_another_window

end
