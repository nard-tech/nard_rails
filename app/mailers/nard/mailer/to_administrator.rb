class Nard::Mailer::ToAdministrator < Nard::Mailer::Master

  default from: Settings::Static.action_mailer.main_email_address
  default to: Settings::Static.action_mailer.main_email_address

  def as_to_contact( contact )
    @contact = contact

    set_containers_as_to_contact

    mail( subject: @contact.decorate.subject ) do | format |
      format.html { render 'mailer/nard/rails/to_administrator/as_to_contact' }
    end
  end

  private

  def set_containers_as_to_contact
    raise 'Please over-ride this method in sub-classes.'
  end

end
