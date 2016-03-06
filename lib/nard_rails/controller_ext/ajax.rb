module Nard::Rails::ControllerExt::Ajax

  private

  def redirect_unless_xhr
    unless request.xhr?
      set_flash_alert_unless_xhr
      redirect_to( redirect_path_unless_xhr )
      return
    end
  end

  def set_flash_alert_unless_xhr
    flash[ :alert ] = '不正なアクセスを検出しました。'
  end

  def redirect_path_unless_xhr
    main_app.root_path
  end

end
