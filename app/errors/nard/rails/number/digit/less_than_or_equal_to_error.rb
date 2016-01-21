require_relative './common_error'

# 桁数が指定された値より大きい不正のときに発生するエラーのクラス
class Nard::Rails::Number::Digit::LessThanOrEqualToError < Nard::Rails::Number::Digit::CommonError

  def message
    " - #{ @number }桁以下の数値を指定してください"
  end

end
