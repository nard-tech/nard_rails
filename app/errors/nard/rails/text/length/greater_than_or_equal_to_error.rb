require_relative './common_error'

# 文字数が指定された値未満の不正のときに発生するエラーのクラス
class Nard::Rails::Text::Length::GreaterThanOrEqualToError < Nard::Rails::Text::Length::CommonError

  def message
    " - #{ @number }文字以上の文字列を指定してください"
  end

end
