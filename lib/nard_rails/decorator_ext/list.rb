# リスト出力のためのメソッドを格納するモジュール
module Nard::Rails::DecoratorExt::List

  extend ActiveSupport::Concern

  module ClassMethods

    # @!group Class methods - Rendering

    def render_header_of_list( search_engine = nil, btns_in_list: true, rowspan: nil )
      h.content_tag( :thead ) {
        first_row = h.content_tag(:tr, class: 'list-tbl__header') {
          ary = []

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
      th_content = ( d.with_sort_link? ? h.sort_link( search_engine, d.attribute, d.label ) : d.label )
      options = { class: d.class_names('column-name') }

      h.content_tag( :th, th_content, options )
    end

    # @!endgroup

  end

  # @!group Instance methods - Rendering

  def render_in_list( btns_in_list: true )
    h.content_tag(:tr, class: tr_class_of_list) {
      ary = []

      self.class::INFOS_ON_LIST_TABLE.each do | column, v |
        ary << render_cell_in_list(v)
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

  def render_cell_in_list(v)
    d = ::Nard::Rails::DecoratorExt::CellDecoration::Html::List::InNormalRow.new(v, self)
    h.content_tag(:td, d.displayed_value, class: d.class_names)
  end

  # @!endgroup

end
