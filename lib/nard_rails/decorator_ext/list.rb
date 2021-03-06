# リスト出力のためのメソッドを格納するモジュール
module Nard::Rails::DecoratorExt::List

  extend ActiveSupport::Concern

  module ClassMethods

    # @!group Class methods - Rendering

    def render_header_of_list( search_engine = nil, btns_in_list: true, rowspan: nil, checkbox: nil )
      h.content_tag( :thead ) {
        first_row = h.content_tag(:tr, class: 'list-tbl__header') {
          ary = []

          if checkbox
            checkbox_options = ( checkbox.instance_of?( Hash ) ? checkbox : {} ).with_indifferent_access
            checkbox_options[:rowspan] = rowspan
            checkbox_options[ :class ] = 'checkbox-column' unless checkbox_options[ :class ].present?
            ary << h.content_tag(:th, '', checkbox_options )
          end

          self::INFOS_ON_LIST_TABLE.each do |column, v|
            ary << render_cell_in_header_of_list( v, column, search_engine )
          end

          if btns_in_list
            ary << h.content_tag(:th, '', class: 'btns-column', rowspan: rowspan )
          end

          ary.join.html_safe
        }

        if rowspan.present?
          tr_ary = []
          tr_ary << first_row

          yield( tr_ary ) if block_given?

          tr_ary.join.html_safe
        else
          first_row
        end
      }
    end

    private

    def render_cell_in_header_of_list( v, column, search_engine = nil )
      d = ::Nard::Rails::DecoratorExt::CellDecoration::Html::List::InHeaderRow.new(v, self, column)

      sort_link_is_required = ( d.with_sort_link? and search_engine.present? )

      th_content = ( sort_link_is_required ? h.sort_link( search_engine, d.attribute, d.label ) : d.label )
      th_content += h.content_tag( :span, ' *', class: :ast ) if sort_link_is_required

      options = { class: d.class_names('column-name') }

      h.content_tag( :th, th_content, options )
    end

    # @!endgroup

  end

  # @!group Instance methods - Rendering

  def render_in_list( btns_in_list: true, checkbox: nil, id: nil, data: nil )
    h.content_tag(:tr, class: tr_class_of_list, id: id, data: data ) {
      ary = []

      if checkbox
        checkbox_options = ( checkbox.instance_of?( Hash ) ? checkbox : {} ).with_indifferent_access
        checkbox_options.merge!( type: :checkbox ) unless checkbox_options[:type].present?
        checkbox_options.merge!( value: false ) unless checkbox_options[:value]
        ary << h.content_tag( :td, class: 'checkbox__outer' ) {
          h.tag( :input, checkbox_options )
        }
      end
      self.class::INFOS_ON_LIST_TABLE.each do | column, v |
        ary << render_cell_in_list( column, v )
      end
      if btns_in_list
        ary << render_btns_in_list
      end

      ary.join.html_safe
    }
  end

  # @!endgroup

  private

  # @!group Private instance methods - Rendering

  def render_table_on_show_page(options)
    h.render(partial: 'shared/show/table', locals: {d: self, infos_on_list_table: self.class::INFOS_ON_LIST_TABLE})
  end

  def tr_class_of_list
    'info-in-list'
  end

  def render_cell_in_list( column, v )
    d = ::Nard::Rails::DecoratorExt::CellDecoration::Html::List::InNormalRow.new(v, self)
    h.content_tag(:td, d.displayed_value, class: d.class_names)
  end

  # @!endgroup

end
