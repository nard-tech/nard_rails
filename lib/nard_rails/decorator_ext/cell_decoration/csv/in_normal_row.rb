# Csv ファイルの各行の値を扱うクラス
class Nard::Rails::DecoratorExt::CellDecoration::Csv::InNormalRow < Nard::Rails::DecoratorExt::CellDecoration::Common::InNormalRow

  def self.displayed_value_of( v, decorator )
    new( v, decorator ).displayed_value
  end

end
