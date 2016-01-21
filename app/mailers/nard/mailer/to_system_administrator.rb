class Nard::Mailer::ToSystemAdministrator < Nard::Mailer::Master

  default from: Settings::Static.action_mailer.system_admin_email_address

  def as_to_error( error_data )
    @error_data = error_data

    send_to = Settings::Static.action_mailer.system_admin_email_address
    send_from = Settings::Static.action_mailer.main_email_address
    subject = "【#{Settings::Static.app_title}】エラー発生"

    mail( to: send_to, from: send_from , subject: subject ) do | format |
      format.html { render }
    end
  end

end
