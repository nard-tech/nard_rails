module Nard::Rails::ControllerExt::Request

  private

  def referrer
    request.referrer
  end

  def referrer_recognized
    @referrer_recognized ||= Rails.application.routes.recognize_path( request.referrer )
  end

  def referrer_url
    url_for( referrer_recognized )
  rescue ActionController::UrlGenerationError => e
    h = referrer_recognized.dup
    h[ :controller ] = "/#{ h[ :controller ] }"
    url_for(h)
  end

  alias :referer :referrer
  alias :referer_recognized :referrer_recognized
  alias :referer_url :referrer_url

end
