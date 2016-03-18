# アクセス権限を確認するメソッドを格納するモジュール
module Nard::Rails::ControllerExt::UserAuthentication

  private

  # アクセス権限を確認するメソッド
  def authenticate_user!( options = {} )
    puts 'Nard::Rails::ControllerExt::UserAuthentication#authenticate_user!' unless Rails.env.production?

    if !( ajax_request? ) and !( user_signed_in? )
      respond_to do | format |
        format.html do
          puts 'Nard::Rails::ControllerExt::UserAuthentication#authenticate_user! - not signed in' unless Rails.env.production?
          redirect_to( new_user_session_path ) and return
        end
        format.json do
          return
        end
      end
    end
  end

  # 管理者としてのアクセス権限を確認するメソッド
  def authenticate_admin_user!( options = {} )
    puts 'Nard::Rails::ControllerExt::UserAuthentication#authenticate_admin_user!' unless Rails.env.production?
    authenticate_user!

    if !( ajax_request? ) and user_signed_in? and !( current_user.administrator? )
      respond_to do | format |
        format.html do
          redirect_to( main_app.root_path ) and return
        end
        format.json do
          head( :no_content ) and return
        end
      end
    end
  end

end
