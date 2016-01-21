# モデルのクラスに対しクラスメソッド 'column_type' を定義するためのモジュール
module Nard::Rails::ModelExt::ColumnType

  extend ActiveSupport::Concern

  module ClassMethods

    # 与えられたフィールドの型を返すメソッド
    # @param column_name [String or Hash] フィールドの名称
    # @param of [String or Hash] フィールドの名称
    # @example
    #    Reservation.column_type(:is_locked)
    #   => "tinyint(1)"
    #    Reservation.column_type(of: :is_locked)
    #   => "tinyint(1)"
    def column_type(column_name=nil, of: nil)
      raise if [column_name, of].all?(&:blank?)
      column_name ||= of
      column_name = column_name.to_s
      columns_hash[column_name].sql_type.to_s
    end

  end

end
