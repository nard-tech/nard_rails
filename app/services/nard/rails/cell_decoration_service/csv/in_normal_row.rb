# Csv ファイルの各行の値を扱うクラス
class Nard::Rails::CellDecorationService::Csv::InNormalRow < Nard::Rails::CellDecorationService::Common::InNormalRow

  def displayed_value
    super().to_s
  end

end
