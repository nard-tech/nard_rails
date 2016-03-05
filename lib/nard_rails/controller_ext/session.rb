# Session の処理を行うメソッドを格納するモジュール
module Nard::Rails::ControllerExt::Session

  # @!group Session

  private

  def session_handler
    @session_handler ||= Nard::Rails::SessionHandler.new(session)
  end

  # @!endgroup

end
