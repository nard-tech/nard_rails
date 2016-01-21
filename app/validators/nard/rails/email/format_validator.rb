# Email address のフォーマットを確認するクラス
class Nard::Rails::Email::FormatValidator < Nard::Rails::Common::FormatValidator

  private

  def valid_regexp
    ApplicationController.helpers.email_regexp
  end

  def error_class
    Nard::Rails::Email::FormatError
  end

end
