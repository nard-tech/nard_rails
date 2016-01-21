# 数値の桁数に関連するエラーのクラス（親クラス）
class Nard::Rails::Number::Digit::CommonError < Nard::Rails::Common::ModelStandardError

  def initialize(obj, field, type, number)
    super(obj, field)
    @type = type
    @number = number
  end

end
