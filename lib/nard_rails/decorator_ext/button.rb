# ボタンを描画するメソッドを格納するモジュール
module Nard::Rails::DecoratorExt::Button

  extend ActiveSupport::Concern

  module ClassMethods

    # @!group Class methods - Rendering

    def render_btn_for_list_page(name: nil, back: true, has_icon: true, icon: nil)
      raise ArgumentError if icon.present? and !( has_icon )

      name ||= "#{ model_name_to_display }一覧"
      name += 'へ戻る' if back
      icon ||= Settings::Static.icons.list if has_icon

      h.basic_button(:div, name, btn_class: 'back-to-list', path: h.url_for(controller: "/#{ self.object_class.name.to_s.tableize }", action: :index), icon: icon )
    end

    # @!endgroup

  end

  # @!group Instance methods - Rendering

  def render_btns_on_edit_page(name: nil, back: true, other_btns: nil, path: nil, target_of_show_page: nil )
    name ||= "この#{ model_name_to_display }の情報"
    name += 'へ戻る' if back
    path ||= object

    h.content_tag( :div, class: [:btns, 'btns--on-edit-page', :clr ] ) {
      btns = []

      btns << h.basic_button(:div, name, btn_class: 'back-to-info', path: path, target: target_of_show_page, icon: Settings::Static.icons.back )

      if other_btns.present?
        [ other_btns ].flatten.each do | other_btn |
          btns << other_btn
        end
      end

      btns << self.class.render_btn_for_list_page

      btns.join.html_safe
    }
  end

  def render_btn_for_show_page(name: nil, path: nil, from_child_model: false)
    if from_child_model
      name ||= "#{ model_name_to_display }の詳細"
    else
      name ||= '詳細'
    end
    path ||= object
    h.basic_button( :div, name, btn_class: :show, path: path, icon: Settings::Static.icons.info )
  end

  # @!endgroup

  private

  # @!group Private instance methods - Rendering

  def render_buttons_on_show_page(_flash, options)
    other_btns = options[:other_btns]
    other_btns = [other_btns].flatten if other_btns.present?

    btn_for_edit_page = options[:btn_for_edit_page]
    btn_for_edit_page ||= true

    h.render(partial: 'shared/show/buttons', locals:{d: self, _flash: _flash, other_btns: other_btns, btn_for_edit_page: btn_for_edit_page})
  end

  def render_btn_for_edit_page(name: nil, path: nil, after_created: false)
    name ||= ( after_created ? "この#{ model_name_to_display }をさらに編集" : '編集' )
    path ||= h.url_for(controller: "/#{ object.class.to_s.tableize }", action: :edit, id: object.id)
    h.basic_button(:div, name, btn_class: :edit, path: path, icon: Settings::Static.icons.edit )
  end

  def render_btn_for_delete(name: nil, path: nil)
    name ||= '削除'
    path ||= object
    h.basic_button(:div, name, btn_class: :delete, path: path, icon: Settings::Static.icons.delete, method_of_link: :delete, data_attr_of_link: { confirm: msg_on_delete } )
  end

  def render_btns_in_list(rowspan: nil, btn_for_delete: true, on_table: true, other_btns: nil, name: nil, outer: { class: 'btns-outer' } )
    options = {}
    name ||= {}
    other_btns = [other_btns].flatten if other_btns.present?

    proc_for_div = Proc.new {
      h.content_tag(:div, class: [:btns, :clr]) {
        btns_ary = []

        btns_ary << render_btn_for_show_page( name: name[:show] )
        btns_ary << render_btn_for_edit_page( name: name[:edit] )

        if other_btns.present?
          other_btns.each do | other_btn |
            btns_ary << other_btn
          end
        end

        if btn_for_delete
          btns_ary << render_btn_for_delete( name: name[:delete] )
        end

        btns_ary.join.html_safe
      }
    }

    if on_table
      options = { class: outer[:class] }
      options[:rowspan] = rowspan if rowspan.present? and on_table

      h.content_tag(:td, options) { proc_for_div.call }
    else
      proc_for_div.call
    end
  end

  alias :__render_btns_in_list__ :render_btns_in_list

  # @!group Private instance methods - Messages

  def msg_on_delete
    "#{ model_name_to_display }「#{ main_value }」を削除します。"
  end

  # @!endgroup

end
