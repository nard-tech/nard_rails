# Csv ファイルの各行の値を扱うクラス
class Nard::Rails::DecoratorExt::CellDecoration::Csv::InNormalRow < Nard::Rails::DecoratorExt::CellDecoration::Common::InNormalRow

  def displayed_value
    super().to_s
  end

end
