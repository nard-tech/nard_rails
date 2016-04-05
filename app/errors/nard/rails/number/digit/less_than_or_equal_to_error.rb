require_relative './standard_error'

# 桁数が指定された値より大きい不正のときに発生するエラーのクラス
class Nard::Rails::Number::Digit::LessThanOrEqualToError < Nard::Rails::Number::Digit::StandardError

  def message
    " - #{ @number }桁以下の数値を指定してください"
  end

end
