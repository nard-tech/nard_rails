# セッション情報を処理するクラス
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
    unless v.nil?
      delete!(k)
    end
    v
  end

  def delete!( *args )
    [ args ].flatten.each do | key |
      if get( key ).present?
        set( key , nil )
      end
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
    record , session_key = to , of
    v = fetch( session_key )
    if v.present?
      record.assign_attributes(v)
    end
  end

  def keys
    @session.keys
  end

  private

  def method_missing( method_name , *args )
    @session.send( method_name , *args )
  end

end
