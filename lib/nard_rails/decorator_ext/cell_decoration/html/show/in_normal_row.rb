# 単一のモデルの各フィールドの情報を表示するリストの各行の値を扱うクラス
class Nard::Rails::DecoratorExt::CellDecoration::Html::Show::InNormalRow < Nard::Rails::DecoratorExt::CellDecoration::Common::InNormalRow

  include Nard::Rails::DecoratorExt::CellDecoration::Common::WithColumn

  def class_names_of_tr( default = nil )
    ary = ( default.present? ? [default].flatten : [] )
    ary << @attribute.to_s.dasherize
    ary
  end

  def class_names_of_value_cell(default = nil)
    ary = ( default.present? ? [default].flatten : [] )
    if number?
      ary << 'text-right'
    end
    ary
  end

end
