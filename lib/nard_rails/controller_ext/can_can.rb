module Nard::Rails::ControllerExt::CanCan

  extend ActiveSupport::Concern

  included do

    rescue_from CanCan::AccessDenied do |exception|
      session_handler.init( :after_sign_in_path, request.url )
      binding.pry unless Rails.env.production? # @todo Delete
      redirect_to( main_app.root_path, alert: "#{ exception.class } - #{ exception.message }" )
    end

  end

end
