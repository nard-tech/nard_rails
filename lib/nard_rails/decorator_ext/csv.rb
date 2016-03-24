# Csv 出力に関連するメソッドを格納するモジュール
module Nard::Rails::DecoratorExt::Csv

  extend ActiveSupport::Concern

  module ClassMethods

    # @!group Class methods - Rendering

    def render_csv_button(controller: nil)
      controller ||= object_class.name.pluralize.underscore
      path = h.url_for( controller: controller, action: :csv, q: h.request[:q] )

      h.content_tag(:div, class: 'link-to-csv__outer') {
        h.basic_button(:div, 'CSV', btn_class: :csv, path: path, icon: Settings::Static.icons.csv )
      }
    end

    # @!group Class methods - Csv

    def header_of_csv
      self::INFOS_ON_CSV.map { |column, v|
      ::Nard::Rails::CellDecorationService::Csv::InHeaderRow.new(v, self, column).label
      }
    end

    # @!endgroup

  end

  # @!group Instance methods - Csv

  def to_csv
    self.class::INFOS_ON_CSV.values.map { |v|
      ::Nard::Rails::CellDecorationService::Csv::InNormalRow.new(v, self).displayed_value
    }.join(',')
  end

  # @!endgroup

end
