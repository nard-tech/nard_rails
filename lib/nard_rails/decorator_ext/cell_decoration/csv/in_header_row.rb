# Csv ファイルのヘッダー（1行目）の値を扱うクラス
class Nard::Rails::DecoratorExt::CellDecoration::Csv::InHeaderRow < Nard::Rails::DecoratorExt::CellDecoration::Common::InHeaderRow

  def self.label_of( v, decorator, column )
    new(v, decorator, column).label
  end

end
