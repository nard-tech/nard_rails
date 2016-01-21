class Nard::Mailer::ToAdministrator < Nard::Mailer::Master

  default from: Settings::Static.action_mailer.main_email_address

  def as_to_contact( contact )
    @contact = contact

    send_to = Settings::Static.action_mailer.main_email_address
    subject = "【#{Settings::Static.app_title}】お問い合わせがありました"

    mail( to: send_to , subject: subject ) do | format |
      format.html { render }
    end
  end

end
