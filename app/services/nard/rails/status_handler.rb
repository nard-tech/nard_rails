class Nard::Rails::StatusHandler

  def get(k)
    obj[ k.to_s ]
  end

  alias :[] :get

  def set( k , v )
    obj[ k.to_s ] = v
  end

  alias :[]= :set

  def fetch(k)
    v = get(k)
    delete!(k) if has_value_for?(k)
    v
  end

  alias :delete :fetch

  def init( k, v )
    has_value_for?(k) ? get(k) : set( k, v )
  end

  def delete!( *args )
    h_deleted = {}
    [ args ].flatten.each do | key |
      if has_value_for?( key )
        h_deleted[ key ] = get(key)
        set( key, nil )
      end
    end

    ( h_deleted.present? ? h_deleted : nil )
  end

  def reset_all!
    delete!( keys )
  end

  def keys
    obj.keys.map( &:to_s )
  end

  private

  def method_missing( method_name , *args )
    obj.send( method_name , *args )
  end

  def has_key?(k)
    keys.include?( k.to_s )
  end

  def has_value_for?(k)
    has_key?(k) and !( get(k).nil? )
  end

end
