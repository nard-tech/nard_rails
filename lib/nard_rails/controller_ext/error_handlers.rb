# 例外処理を行うモジュール
module Nard::Rails::ControllerExt::ErrorHandlers

  extend ActiveSupport::Concern

  included do
    # 例外ハンドル
    rescue_from Exception, with: :rescue_500

    rescue_from Nard::Rails::Controller::Forbidden, with: :rescue_403
    rescue_from Nard::Rails::Controller::IpAddressRejected, with: :rescue_403

    rescue_from ActionController::RoutingError, with: :rescue_404
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_404
    rescue_from ActionView::MissingTemplate, with: :rescue_404
  end

  private

  def rescue_403( e = nil )
    @exception = e
    logger.error "Rendering 403 with exception: #{@exception.message}" if @exception

    if ajax_request?
      render json: { error: '403 error (forbidden)' }, status: :forbidden , layout: nil
    else
      render template: 'errors/forbidden', status: :forbidden , content_type: 'text/html'
    end
  end

  def rescue_404(e = nil)
    @exception = e
    logger.error "Rendering 404 with exception: #{@exception.message}" if @exception

    if ajax_request?
      render json: { error: '404 error (not found)' }, status: :not_found , layout: nil
    else
      render template: 'errors/not_found', status: :not_found , content_type: 'text/html'
    end
  end

  def rescue_500(e = nil)
    @exception = e
    if @exception
      error_data = {
        e: e,
        controller_name: controller_name,
        action_name: action_name,
        user: __current_user__,
        params: params,
        backtrace: @exception.backtrace
      }
      logger.error "####ERROR### Rendering 500 with exception: #{error_data.inspect}"
    end

    begin
      error_data_in_mail = error_data.except(:e).merge({
        error_inspect: @exception.inspect
      })
      Mailer::ToSystemAdministrator.as_to_error( error_data_in_mail ).deliver_later
    rescue Net::SMTPFatalError
      logger.error "Rendering 500 with exception: SMTPFatalError"
    end

    if ajax_request?
      render json: { error: '500 error' }, status: :internal_server_error , layout: nil
    else
      render template: 'errors/internal_server_error', status: :internal_server_error , content_type: 'text/html'
    end
  end

  def __current_user__
    if respond_to?(:_current_user, true) and rails_admin_controller?
      _current_user
    else
      current_user
    end
  end

end
