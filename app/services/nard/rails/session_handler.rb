# Session の処理を行うクラス
class Nard::Rails::SessionHandler < Nard::Rails::StatusHandler

  def initialize( session )
    @session = session
  end

  def reset!( h = { unless: [ :session_id, :_csrf_token , "warden.user.user.key" ] } )
    args = keys
    if h[ :unless ].present?
      args = args.map( &:to_s ) - h[ :unless ].map( &:to_s )
    end

    delete!( *args )
  end

  def delegate_attributes( of:, to: )
    record, session_key = to, of
    v = fetch( session_key )
    record.assign_attributes(v) if v.present?
  end

  private

  def obj
    @session
  end

end
