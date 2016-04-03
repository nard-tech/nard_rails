# 複数のモデルの情報を表示するリストのヘッダーの値を扱うクラス
class Nard::Rails::CellDecorationService::Html::List::InHeaderRow < Nard::Rails::CellDecorationService::Common::InHeaderRow

  include Nard::Rails::CellDecorationService::Html::List::ClassNames

  def label
    str = super()
    return nil unless str.present?
    str.to_s.split(/ /).join( '<br />' ).html_safe
  end

end
