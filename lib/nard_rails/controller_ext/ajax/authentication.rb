module Nard::Rails::ControllerExt::Ajax::Authentication

  private

  def authenticate_user_on_ajax
    unless valid_user_on_ajax?
      inspect_ajax_authentication_infos
      render( json: {}, status: :unauthorized )
      return
    end
  end

  def authenticate_ajax_access
    unless valid_ajax_access?
      inspect_ajax_authentication_infos
      render( json: {}, status: :not_acceptable )
    end
  end

  def valid_user_on_ajax?( obj )
    # puts ability_property unless Rails.env.production?
    # puts obj unless Rails.env.production?
    user_signed_in? and can?( ability_property, obj )
  end

  def valid_ajax_access?
    false
  end

  def inspect_ajax_authentication_infos
    unless Rails.env.production?
      puts "user_signed_in?: #{ user_signed_in? }"
      puts "current_user.id: #{ current_user.try(:id) }"
      yield if block_given?
    end
  end

end
