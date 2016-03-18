class Nard::Rails::AjaxController < Nard::Rails::AppController

  respond_to :json
  before_action :redirect_unless_xhr

  protect_from_forgery with: :null_session

  include Nard::Rails::ControllerExt::Ajax::Authentication

end
