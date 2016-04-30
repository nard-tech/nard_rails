# 複数のモデルの情報を表示するリストのヘッダーの値を扱うクラス
class Nard::Rails::DecoratorExt::CellDecoration::Html::List::InHeaderRow < Nard::Rails::DecoratorExt::CellDecoration::Common::InHeaderRow

  include Nard::Rails::DecoratorExt::CellDecoration::Html::List::ClassNames

  def label
    str = super()
    return nil unless str.present?
    str.to_s.split(/ /).join( '<br />' ).html_safe
  end

end
