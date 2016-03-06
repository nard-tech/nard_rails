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

  def referrer_url
    url_for( referrer_recognized )
  rescue ActionController::UrlGenerationError => e
    h = referrer_recognized.dup
    h[ :controller ] = "/#{ h[ :controller ] }"
    url_for(h)
  end

  alias :referer_url :referrer_url

end
