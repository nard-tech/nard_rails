module Nard::Rails::ControllerExt::Ajax::Flash

  extend ActiveSupport::Concern

  included do
    add_flash_types :ajax_notice, :ajax_alert
  end

end
