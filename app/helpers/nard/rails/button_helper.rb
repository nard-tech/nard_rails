module Nard::Rails::ButtonHelper

  def basic_button( tag_type, text = nil, btn_class: nil, btn_id: nil, path: nil, target: nil, layout_type: :h, icon: nil, icon_size: nil, method_of_link: nil, data_attr_of_link: nil, form: nil, children: nil, hidden: false, additional_btn_classes: nil, data_attributes: nil )
    raise ArgumentError unless [ 'div', 'submit', 'submit_button' ].include?(tag_type.to_s)
    raise ArgumentError if text.present? and !( text.kind_of?( String ) or text.instance_of?( Symbol ) )
    if btn_class.present?
      raise ArgumentError unless btn_class.instance_of?( String ) or btn_class.instance_of?( Symbol )
    end
    raise ArgumentError unless layout_type.instance_of?( String ) or layout_type.instance_of?( Symbol )
    raise ArgumentError if path.blank? and target.present?

    div_classes = [ :btn, "btn-#{ layout_type }", :clr ]
    div_classes << 'link-btn' if path.present?
    div_classes << "btn--#{ btn_class }" if btn_class.present?
    div_classes << :hidden if hidden

    if additional_btn_classes.present?
      div_classes << additional_btn_classes
      div_classes.flatten!
    end

    link_html = ( path.present? ? link_to( '', path, method: method_of_link, data: data_attr_of_link, target: target ) : '' )

    if icon.present?
      icon_classes = [ icon.to_s.dasherize, 'fw' ]
      icon_classes << "#{ icon_size }x" if icon_size.present?
      icon_and_text_html = fa_icon_nd( icon_classes, text: text )
    else
      icon_and_text_html = text
    end

    html = ( link_html + icon_and_text_html ).html_safe
    options = { class: div_classes, id: btn_id, data: data_attributes }
    tag_name = ( tag_type.to_s == 'div' ? :div : :button )

    options[:type] = 'submit' if tag_name == :button
    content_tag( tag_name, html, options )
  end

  # @!endgroup

end
