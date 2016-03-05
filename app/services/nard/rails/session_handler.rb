# Session の処理を行うクラス
class Nard::Rails::SessionHandler

  def initialize( session )
    @session = session
  end

  def get(k)
    @session[ k.to_s ]
  end

  def set( k , v )
    @session[ k.to_s ] = v
  end

  def fetch(k)
    v = get(k)
    delete!(k) unless v.nil?
    v
  end

  def delete!( *args )
    [ args ].flatten.each do | key |
      set( key, nil ) if get( key ).present?
    end
  end

  def reset!( h = { unless: [ :session_id, :_csrf_token , "warden.user.user.key" ] } )
    args = keys
    if h[ :unless ].present?
      args = args.map( &:to_s ) - h[ :unless ].map( &:to_s )
    end

    delete!( *args )
  end

  def reset_all!
    delete!( keys )
  end

  def delegate_attributes( of:, to: )
    record, session_key = to, of
    v = fetch( session_key )
    record.assign_attributes(v) if v.present?
  end

  def keys
    @session.keys
  end

  private

  def method_missing( method_name , *args )
    @session.send( method_name , *args )
  end

end
