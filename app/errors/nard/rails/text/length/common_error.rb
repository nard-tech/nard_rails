# 文字数に関連するエラーのクラス（親クラス）
class Nard::Rails::Text::Length::CommonError < Nard::Rails::Common::ModelStandardError

  def initialize(obj, field, type, number)
    super(obj, field)
    @type = type
    @number = number
  end

end
