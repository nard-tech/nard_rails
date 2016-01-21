# 名称が is_xxxx, 型が Boolean の field の値をメソッド 'xxxx?' によって参照できるようにするモジュール
# @note
#   Rails 標準では、名称が xxxx, 型が Boolean の field の値をメソッド 'xxxx?' によって参照することができる。
#   したがって、フィールド is_xxxx <Boolean> が存在するとき、メソッド 'is_xxxx?' は実行可能だが、'xxxx?' は実行できない。
#
#   RSpecでは、オブジェクト model に対し xxxx? が実行可能な場合、
#
#   expect(model).to be_xxxx
#
#   というテストを書くことになるので、フィールド is_xxxx をもつモデル（のオブジェクト）に対しメソッド 'xxxx?' が存在するほうが都合がよい。
#
#   以上の理由から、このモジュールを定義した。
# @note
#   メソッドは included 節内で動的に定義する。
module Nard::Rails::ModelExt::BooleanProcessor

  extend ActiveSupport::Concern

  included do

    column_names.each do |column|
      if /^is_/ === column.to_s and ['tinyint(1)'].include?(column_type(of: column).to_s)
        eval <<-DEF
          def #{column.to_s.gsub(/^is_/, '')}?
            if #{column}
              true
            else
              false
            end
          end
        DEF
      end
    end

  end

end
