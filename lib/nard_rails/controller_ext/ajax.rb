module Nard::Rails::ControllerExt::Ajax

  extend ActiveSupport::Concern

  included do
    rescue_from Nard::Rails::Controller::AjaxError, with: :rescue_if_xhr
    rescue_from Nard::Rails::Controller::NotAjaxError, with: :rescue_unless_xhr
  end

  private

  def ajax_request?
    request.xhr?
  end

  # @!group If xhr - Ajax を受け付けない場合

  def reject_if_xhr
    raise Nard::Rails::Controller::AjaxError if ajax_request?
  end

  alias :redirect_if_xhr :reject_if_xhr

  def rescue_if_xhr
    render( json: {}, status: :not_acceptable )
    return
  end

  # @!group Unless xhr - Ajax のみを受け付ける場合

  def reject_unless_xhr
    raise Nard::Rails::Controller::NotAjaxError unless ajax_request?
  end

  alias :redirect_unless_xhr :reject_unless_xhr

  def rescue_unless_xhr
    set_flash_alert_unless_xhr
    redirect_to( redirect_path_unless_xhr( params[:action] ), format: :html, status: :not_acceptable )
    return
  end

  def set_flash_alert_unless_xhr
    flash[ :alert ] = '不正なアクセスを検出しました。'
  end

  def redirect_path_unless_xhr( action = nil )
    main_app.root_path
  end

  # @!endgroup

end
