# リスト出力のためのメソッドを格納するモジュール
module Nard::Rails::DecoratorExt::List

  extend ActiveSupport::Concern

  module ClassMethods

    # @!group Class methods - Rendering

    def render_header_of_list(btns_in_list: true)
      h.content_tag(:thead) {
        h.content_tag(:tr, class: 'list-tbl__header') {
          self::INFOS_ON_LIST_TABLE.each do |column, v|
            d = ::Nard::Rails::CellDecorationService::Html::Header.new(v, self, column)
            h.concat h.content_tag(:th, d.label, class: d.class_names('column-name'))
          end
          if btns_in_list
            h.concat h.content_tag(:th, '', class: 'btns-column')
          end
        }
      }
    end

    # @!endgroup

  end

  # @!group Instance methods - Rendering

  def render_in_list( btns_in_list: true )
    h.content_tag(:tr, class: tr_class_of_list) {
      self.class::INFOS_ON_LIST_TABLE.values.each do |v|
        d = ::Nard::Rails::CellDecorationService::Html::List::InNormalRow.new(v, self)
        h.concat h.content_tag(:td, d.displayed_value, class: d.class_names)
      end
      if btns_in_list
        h.concat(render_btns_in_list)
      end
    }
  end

  # @!endgroup

  private

  # @!group Private instance methods - Rendering

  def render_table_on_show_page(options)
    h.concat h.render(partial: 'shared/show/table', locals: {d: self, infos_on_list_table: self.class::INFOS_ON_LIST_TABLE})
    nil
  end

  def tr_class_of_list
    'info-in-list'
  end

  # @!endgroup

end
