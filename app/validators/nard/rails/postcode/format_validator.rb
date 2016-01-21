# 郵便番号のフォーマットを確認するクラス
class Nard::Rails::Postcode::FormatValidator < Nard::Rails::Common::FormatValidator

  private

  def valid_regexp
    ApplicationController.helpers.postcode_regexp
  end

  def error_class
    Nard::Rails::Postcode::FormatError
  end

end
