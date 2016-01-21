# 標準的なエラーの基底クラス
# @note モデルのインスタンスとエラーが発生しているフィールド名をインスタンス変数にもつ。
class Nard::Rails::Common::ModelStandardError < ::StandardError

  def initialize(obj = nil, field = nil)
    @obj = obj
    @field = field
  end

  attr_reader :field

end
