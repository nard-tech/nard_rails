class Nard::Rails::ModelExt::ArelExt::Time::AttributeWrapper

  def initialize( arel_attribute )
    @arel_attribute = arel_attribute
  end

  def before( time, eq: false )
    raise ArgumentError unless eq == true or eq == false
    eq ? @arel_attribute.lteq( time ) : @arel_attribute.lt( time ) # <= /<
  end

  def after( time, eq: false )
    raise ArgumentError unless eq == true or eq == false
    eq ? @arel_attribute.gteq( time ) : @arel_attribute.gt( time ) # >= />
  end

end
