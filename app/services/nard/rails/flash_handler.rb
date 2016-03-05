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
      set( key, var )
      return
    end

    #--------

    default_keys = [ options.delete(:default) ].flatten
    completed = false

    default_keys.each do | key |
      if get( key ).present?
        set( key, "#{ get( key ) }#{ var }" )
        completed = true
        break
      end
    end
    return if completed

    #--------

    set( default_keys.first, var )
  end

  alias :reset! :reset_all!

  private

  def obj
    @flash
  end

end
