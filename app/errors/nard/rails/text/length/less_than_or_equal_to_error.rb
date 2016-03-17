require_relative './common_error'

# 文字数が指定された値より大きい不正のときに発生するエラーのクラス
class Nard::Rails::Text::Length::LessThanOrEqualToError < Nard::Rails::Text::Length::CommonError

  def message
    " - #{ @number }文字以下の文字列を指定してください"
  end

end
