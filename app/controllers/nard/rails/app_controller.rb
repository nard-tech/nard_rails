class Nard::Rails::AppController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout "layouts/application"

  # @!group Errors

  if Rails.env.production? or Rails.env.test?
    include Nard::Rails::ControllerExt::ErrorHandlers
  end

  # @!group Authentication

  include Nard::Rails::ControllerExt::UserAuthentication
  include Nard::Rails::ControllerExt::CanCan
  include Nard::Rails::ControllerExt::Ability

  # @!group Session

  include Nard::Rails::ControllerExt::Session

  # @!group Flash

  include Nard::Rails::ControllerExt::Flash

  # @!group Request

  include Nard::Rails::ControllerExt::Request

  # @!group Ajax

  include Nard::Rails::ControllerExt::Ajax

  # @!group Json

  include Nard::Rails::ControllerExt::Json

  # @!group RailsAdmin

  include Nard::Rails::ControllerExt::Admin

  # @!endgroup

end
