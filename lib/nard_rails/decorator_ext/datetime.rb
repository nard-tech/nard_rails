# 日付・時刻に関するフィールドを #l によって標準的な文字列に変換して返すメソッドを定義するモジュール
module Nard::Rails::DecoratorExt::Datetime

  extend ActiveSupport::Concern

  included do

    object_class.column_names.each do |column|
      case object_class.column_type(of: column).to_s
      when 'datetime'
        format_name = :normal
      when 'time'
        format_name = :only_time_short
      else
        format_name = nil
      end

      if format_name.present?
        eval <<-DEF
          def #{column}
            if object.#{column}.present?
              h.l(object.#{column}, format: :#{format_name})
            else
              nil
            end
          end
        DEF
      end
    end

  end

end
