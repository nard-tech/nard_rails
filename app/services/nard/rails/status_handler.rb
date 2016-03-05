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
    delete!(k) unless v.nil?
    v
  end

  def delete!( *args )
    [ args ].flatten.each do | key |
      set( key, nil ) if get( key ).present?
    end
  end

  def reset_all!
    delete!( keys )
  end

  def keys
    obj.keys
  end

  private

  def method_missing( method_name , *args )
    obj.send( method_name , *args )
  end

end
