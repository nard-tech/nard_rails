class Nard::Mailer::ToSystemAdministrator < Nard::Mailer::Master

  default from: Settings::Static.action_mailer.main_email_address
  default to: Settings::Static.action_mailer.system_admin_email_address

  def as_to_error( error_data )
    @error_inspection = error_data[:error_inspect]
    @error_data_formatted = {
      time: ApplicationController.helpers.l( Time.now ),
      controller_name: error_data[:controller_name],
      action_name: error_data[:action_name],
      user: error_data[:user].inspect,
      params: error_data[:params].inspect
    }
    @error_backtrace = error_data[:backtrace]

    subject = "【#{Settings::Static.app_title}】エラー発生"

    mail( subject: subject ) do | format |
      format.html { render 'mailer/nard/rails/to_system_administrator/as_to_error' }
    end
  end

end
