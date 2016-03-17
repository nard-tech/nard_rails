require_relative './common_error'

# 文字数が指定された値以上の不正のときに発生するエラーのクラス
class Nard::Rails::Text::Length::LessThanError < Nard::Rails::Text::Length::CommonError

  def message
    " - #{ @number }文字未満の文字列を指定してください"
  end

end
