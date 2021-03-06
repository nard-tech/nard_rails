require_relative './standard_error'

# 桁数が指定された値以上の不正のときに発生するエラーのクラス
class Nard::Rails::Number::Digit::LessThanError < Nard::Rails::Number::Digit::StandardError

  def message
    " - #{ @number }桁未満の桁数の数値を指定してください"
  end

end
