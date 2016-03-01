module Nard::Rails::ControllerExt::Request

  private

  def referrer
    request.referrer
  end

  alias :referer :referrer

  def referrer_recognized
    @referrer_recognized ||= Rails.application.routes.recognize_path( request.referrer )
  end

  alias :referer_recognized :referrer_recognized

end
