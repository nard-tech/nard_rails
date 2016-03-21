class Nard::Rails::ModelExt::ArelExt::ReplacedString::AttributeWrapper < Arel::Nodes::NamedFunction

  def initialize( arel_attribute, from, to )
    # @see http://qiita.com/patorash/items/e42d75b79be3eab1e5eb
    args = [ arel_attribute, from, to ].map { | arg | ::Arel::Nodes.build_quoted( arg ) }

    super( 'REPLACE', args )
  end

  def like( pattern )
    matches( pattern )
  end

end
