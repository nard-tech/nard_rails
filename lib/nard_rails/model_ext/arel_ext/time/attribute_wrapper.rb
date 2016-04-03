class Nard::Rails::ModelExt::ArelExt::Time::AttributeWrapper

  def initialize( arel_attribute )
    @arel_attribute = arel_attribute
  end

  def before( time, options = {} )
    eq_setting( options ) ? @arel_attribute.lteq( time ) : @arel_attribute.lt( time ) # <= /<
  end

  def after( time, options = {} )
    eq_setting( options ) ? @arel_attribute.gteq( time ) : @arel_attribute.gt( time ) # >= />
  end

  private

  def eq_setting( options )
    return !!( options ) if options == true or options == false or options == nil or options == :eq
    options.with_indifferent_access[:eq]
  rescue
    raise ArgumentError, 'Please set boolean, nil, symbol \':eq\' or hash with key \'eq\' (string or symbol)'
  end

end
