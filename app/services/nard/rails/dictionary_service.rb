class Nard::Rails::DictionaryService < Nard::Rails::DictionaryMetaService

  def initialize( ref, debug_mode: false )
    super( ref, debug_mode )

    @model = @ary[0].camelize.constantize

    if @debug_mode
      puts "model: #{ @model.name }"
    end
  end

  # @see http://rails3try.blogspot.jp/2012/01/rails3-i18n.html
  def to_s
    if get_model_name?
      @model.model_name.human
    elsif get_attribute_name?
      field_name = @ary[1]
      @model.human_attribute_name( field_name )
    elsif get_enumerize_value?
      h.t( "enumerize.#{ @model.to_s.underscore }.#{ @ary[2] }.#{ @ary[3] }")
    elsif get_decorator_attribute_name?
      h.t( "activerecord.decorators.#{ @model.to_s.underscore }.#{ @ary[2] }.#{ @ary[3] }")
    elsif get_other_option_name?
      h.t( "activerecord.#{ @ary[1].pluralize }.#{ @model.to_s.underscore }.#{ @ary[2] }")
    else
      raise Nard::Rails::DictionaryService::InvalidReferenceError
    end
  rescue Nard::Rails::DictionaryService::InvalidReferenceError => e
    h.t( @ref )
  end

  private

  def get_model_name?
    @ary.length == 1
  end

  def get_attribute_name?
    @ary.length == 2
  end

  def get_enumerize_value?
    @ary.length == 4 and @ary[1] == 'enumerize'
  end

  def get_decorator_attribute_name?
    @ary.length == 4 and @ary[1] == 'decorator'
  end

  def get_other_option_name?
    @ary.length == 3
  end

end
