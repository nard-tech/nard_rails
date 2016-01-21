require_relative './common_error'

# 桁数が指定された値未満の不正のときに発生するエラーのクラス
class Nard::Rails::Number::Digit::GreaterThanOrEqualToError < Nard::Rails::Number::Digit::CommonError

  def message
    " - #{ @number }桁以上の数値を指定してください"
  end

end
