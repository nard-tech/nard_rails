module Nard::Rails::ControllerExt::Json

  extend ActiveSupport::Concern

  included do
    rescue_from Nard::Rails::Controller::JsonError, with: :rescue_if_json
    rescue_from Nard::Rails::Controller::NotJsonError, with: :rescue_unless_json
  end

  private

  def json_request?
    request.format == :json
  end

  # @!group If Json - Json を受け付けない場合

  def reject_if_json
    raise Nard::Rails::Controller::JsonError if json_request?
  end

  alias :redirect_if_json :reject_if_json

  # @note Json を受け付けない場合は、Json でエラーを返す。
  def rescue_if_json
    set_flash_alert_if_json
    render( json: {}, status: :unsupported_media_type )
    return
  end

  # @!group Unless Json - Json 以外を受け付けない場合

  def reject_unless_json
    raise Nard::Rails::Controller::NotJsonError unless json_request?
  end

  alias :redirect_unless_json :reject_unless_json

  # @note Json 以外を受け付けない場合は、Html でエラーを返す。
  def rescue_unless_json
    set_flash_alert_unless_json
    redirect_to( redirect_path_unless_json, format: :html, status: :unsupported_media_type )
    return
  end

  def set_flash_alert_unless_json
    flash[ :alert ] = '不正なアクセスを検出しました。'
  end

  def redirect_path_unless_json
    main_app.root_path
  end

  # @!endgroup

end
