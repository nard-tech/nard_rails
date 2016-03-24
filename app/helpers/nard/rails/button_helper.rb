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
    proc = Proc.new {
      content_tag( :div, '', class: ['n-alerts', :btn__content, 'n-alerts--default'], id: 'js-n-alerts' )
    }

    basic_button( :div, proc, btn_class: 'action-alert', btn_id: 'js-action-alert__btn', icon: Settings::Static.icons.alert )
  end

  # @!endgroup

  def basic_button( tag_type, title = nil, btn_class: nil, btn_id: nil, path: nil, layout_type: :h, icon: nil, icon_size: 1, method_of_link: nil, data_attr_of_link: nil, form: nil, children: nil )
    raise ArgumentError unless btn_class.instance_of?( String ) or btn_class.instance_of?( Symbol )
    raise ArgumentError unless layout_type.instance_of?( String ) or layout_type.instance_of?( Symbol )

    div_classes = [ :btn, 'link-btn', "btn--#{ btn_class }", "btn-#{ layout_type }", :clr ]

    proc_of_content = Proc.new {
      link = ''

      if path.present?
        link = link_to( '', path, method: method_of_link, data: data_attr_of_link )
      elsif form.present?
        case btn_class.to_s
        when 'add'
          if children.present?
            link = form.link_to_add( '', children )
          end
        when 'remove'
          link = form.link_to_remove( '' )
        end
      end

      btn_contents = content_tag( :div, class: [ 'btn__contents', :clr ] ) {
        ary = []

        if icon.present?
          ary << content_tag( :div, class: [ 'btn__icon-outer', :btn__content ] ) {
            content_tag( :i, '', class: [ :fa, "fa-#{ icon_size }x", "fa-#{ icon.to_s.dasherize }", :btn__icon ] )
          }
        end

        if title.present?
          if title.instance_of?( String ) or title.instance_of?( Symbol )
            ary << content_tag( :div , title , class: [ :btn__title , :btn__content ] )
          else title.instance_of?( Proc )
            ary << title.call
          end
        end

        ary.join.html_safe
      }

      ( link + btn_contents ).html_safe
    }

    case tag_type.to_s
    when 'div'
      content_tag( :div, class: div_classes, id: btn_id, &proc_of_content )
    when 'submit', 'submit_button'
      content_tag( :button, class: div_classes, type: :submit, id: btn_id, &proc_of_content )
    end
  end

  # @!endgroup

end
