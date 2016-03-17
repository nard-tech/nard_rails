require_relative './common_error'

# 文字数が指定された値以下の不正のときに発生するエラーのクラス
class Nard::Rails::Text::Length::GreaterThanError < Nard::Rails::Text::Length::CommonError

  def message
    " - #{ @number }文字より長い文字列を指定してください"
  end

end
