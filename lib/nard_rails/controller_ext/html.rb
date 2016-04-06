module Nard::Rails::ControllerExt::Html

  extend ActiveSupport::Concern

  included do
    rescue_from Nard::Rails::Controller::HtmlError, with: :rescue_if_html
    rescue_from Nard::Rails::Controller::NotHtmlError, with: :rescue_unless_html
  end

  private

  def html_request?
    request.format == :html
  end

  # @!group If Html - Html を受け付けない場合

  def reject_if_html
    raise Nard::Rails::Controller::HtmlError if html_request?
  end

  alias :redirect_if_html :reject_if_html

  # @note Html を受け付けない場合は、Html でエラーを返す。
  def rescue_if_html
    set_flash_alert_if_html
    redirect_to( redirect_path_if_html, format: :html, status: :unsupported_media_type )
    return
  end

  def set_flash_alert_if_html
    flash[ :alert ] = '不正なアクセスを検出しました。'
  end

  def redirect_path_if_html
    main_app.root_path
  end

  # @!group Unless Html - Html 以外を受け付けない場合

  def reject_unless_html
    raise Nard::Rails::Controller::NotHtmlError unless html_request?
  end

  alias :redirect_unless_html :reject_unless_html

  # @note Html 以外を受け付けない場合、Json ならば Json で、Json 以外は Html でエラーを返す。
  def rescue_unless_html
    if request.format == :json
      render( json: {}, status: :unsupported_media_type )
      return
    else
      set_flash_alert_unless_html
      redirect_to( redirect_path_unless_html, format: :html, status: :unsupported_media_type )
      return
    end
  end

  def set_flash_alert_unless_html
    flash[ :alert ] = '不正なアクセスを検出しました。'
  end

  def redirect_path_unless_html
    main_app.root_path
  end

  # @!endgroup

end
