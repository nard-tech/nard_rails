module Nard::Rails::ButtonHelper

  # @!group Buttons

  def menu_display_button( path = nil )
    basic_button( :div, 'メニュー', btn_class: :menu, path: path, icon: Settings::Static.icons.menu, layout_type: :h , btn_id: 'js-menu-display-btn' )
  end

  def menu_fix_button
    basic_button( :div, '表示を固定', btn_class: 'menu-fix', icon: Settings::Static.icons.fix, layout_type: :h, btn_id: 'js-menu-fix-btn' )
  end

  def create_button( controller = nil , layout_type: :h )
    link_path = ( controller.present? ? url_for( controller: controller , action: :new ) : nil )

    basic_button( :div, '新規登録', btn_class: 'creating-new', btn_id: 'js-create-btn', path: link_path, icon: Settings::Static.icons.add, layout_type: layout_type )
  end

  def submit_button( btn_id: nil , name: '登録', has_icon: true, icon: nil )
    raise ArgumentError if icon.present? and !( has_icon )

    icon ||= Settings::Static.icons.submit if has_icon

    basic_button( :submit_button, name , btn_class: :save, btn_id: btn_id, icon: icon )
  end

  def search_button( btn_id: nil, name: '検索', has_icon: true, icon: nil )
    raise ArgumentError if icon.present? and !( has_icon )

    icon ||= Settings::Static.icons.search if has_icon

    basic_button( :submit_button, name , btn_class: :search, btn_id: btn_id, icon: icon )
  end

  def shop_button( shop = nil )
    raise ArgumentError unless shop.present?
    basic_button( :div, shop.name, btn_class: :shop, btn_id: 'js-shop__btn', icon: Settings::Static.icons.shop )
  end

  def action_alert_button
    title = content_tag( :div, '', class: ['n-alerts', :btn__content, 'n-alerts--default'], id: 'js-n-alerts' )
    basic_button( :div, title, btn_class: 'action-alert', btn_id: 'js-action-alert__btn', icon: Settings::Static.icons.alert )
  end

  # @!endgroup

  def basic_button( tag_type, title = nil, btn_class: nil, btn_id: nil, path: nil, layout_type: :h, icon: nil, icon_size: nil, method_of_link: nil, data_attr_of_link: nil, form: nil, children: nil, hidden: false )
    raise ArgumentError unless [ 'div', 'submit', 'submit_button' ].include?(tag_type.to_s)
    raise ArgumentError if title.present? and !( title.kind_of?( String ) or title.instance_of?( Symbol ) )
    raise ArgumentError unless btn_class.instance_of?( String ) or btn_class.instance_of?( Symbol )
    raise ArgumentError unless layout_type.instance_of?( String ) or layout_type.instance_of?( Symbol )

    div_classes = [ :btn, 'link-btn', "btn--#{ btn_class }", "btn-#{ layout_type }", :clr ]
    if hidden
      div_classes << :hidden
    end

    link_html = ( path.present? ? link_to( '', path, method: method_of_link, data: data_attr_of_link ) : '' )

    if icon.present?
      icon_classes = [ icon.to_s.dasherize, 'fw' ]
      icon_classes << "#{ icon_size }x" if icon_size.present?
      icon_and_text_html = fa_icon_nd( icon_classes, text: title )
    else
      icon_and_text_html = title
    end

    html = ( link_html + icon_and_text_html ).html_safe
    options = { class: div_classes, id: btn_id }
    tag_name = ( tag_type.to_s == 'div' ? :div : :button )

    options[:type] = 'submit' if tag_name == :button
    content_tag( tag_name, html, options )
  end

  # @!endgroup

end
