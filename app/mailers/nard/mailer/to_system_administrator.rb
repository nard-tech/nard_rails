class Nard::Mailer::ToSystemAdministrator < Nard::Mailer::Master

  default from: Settings::Static.action_mailer.main_email_address
  default to: Settings::Static.action_mailer.system_admin_email_address

  def as_to_error( error_data )
    @error_data = error_data

    subject = "【#{Settings::Static.app_title}】エラー発生"

    mail( subject: subject ) do | format |
      format.html { render 'mailer/nard/rails/to_system_administrator/as_to_error' }
    end
  end

end
