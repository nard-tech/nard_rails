class Nard::Rails::DictionaryMetaService

  def initialize( ref, debug_mode )
    @ref = ref
    @ary = ref.split('.')

    @debug_mode = debug_mode

    if @debug_mode
      puts ''
      puts "ref: #{ @ref }"
      puts "ary: #{ @ary.to_s }"
    end
  end

  private

  def h
    ApplicationController.helpers
  end

end
