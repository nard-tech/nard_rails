# 電話番号のフォーマットを確認するクラス
class Nard::Rails::Telephone::FormatValidator < Nard::Rails::Common::FormatValidator

  private

  def valid_regexp
    if options[:require_full] == true
      ApplicationController.helpers.tel_regexp
    else
      ApplicationController.helpers.tel_regexp( require_area_code: false ) # , allow_prefix: true
    end
  end

  def error_class
    Nard::Rails::Telephone::FormatError
  end

end
