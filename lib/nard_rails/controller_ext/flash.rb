# Flash の処理を行うメソッドを格納するモジュール
module Nard::Rails::ControllerExt::Flash

  # @!group Session

  private

  def flash_handler
    @flash_handler ||= Nard::Rails::FlashHandler.new(flash)
  end

  # @!endgroup

end
