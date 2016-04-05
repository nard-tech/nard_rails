# 数値の桁数に関連するエラーの基底クラス
class Nard::Rails::Number::Digit::StandardError < Nard::Rails::Common::ModelStandardError

  def initialize(obj, field, type, number)
    super(obj, field)
    @type = type
    @number = number
  end

end
