# Session の処理を行うクラス
class Nard::Rails::FlashHandler < Nard::Rails::StatusHandler

  def initialize( flash )
    @flash = flash
  end

  def add( var, options = nil )
    options ||= { to: :notice }
    key ||= options.delete(:to)

    #--------

    if key.present?
      return set( key, var )
    end

    #--------

    default_keys = [ options.delete(:default) ].flatten
    raise unless default_keys.present?
    key = nil

    default_keys.each do | k |
      if has_value_for?( k )
        set( k, "#{ get( k ) }#{ var }" )
        key = k
        break
      end
    end
    return get(key) if key

    #--------

    set( default_keys.first, var )
  end

  alias :reset! :reset_all!

  private

  def obj
    @flash
  end

end
