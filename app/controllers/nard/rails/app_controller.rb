class Nard::Rails::AppController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout "layouts/application"

  # @!group Errors

  if Rails.env.production? or Rails.env.test?
    include Nard::Rails::ControllerExt::ErrorHandlers
  end

  # @!group Session

  include Nard::Rails::ControllerExt::Session

  # @!endgroup

end
