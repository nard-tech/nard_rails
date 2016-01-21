# 電話番号のフォーマットを確認するクラス
class Nard::Rails::Telephone::FormatValidator < Nard::Rails::Common::FormatValidator

  private

  def valid_regexp
    ApplicationController.helpers.tel_regexp
  end

  def error_class
    Nard::Rails::Telephone::FormatError
  end

end
