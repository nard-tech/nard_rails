require_relative './common_error'

# 桁数が指定された値以下の不正のときに発生するエラーのクラス
class Nard::Rails::Number::Digit::GreaterThanError < Nard::Rails::Number::Digit::CommonError

  def message
    " - #{ @number }桁より大きい桁数の数値を指定してください"
  end

end
