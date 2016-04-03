module Nard::Rails::ModelExt::Scopes::Fax

  include Nard::Rails::ModelExt::ArelExt::ReplacedString
  extend ActiveSupport::Concern

  included do

    scope :fax_search, -> ( str ) {
      fax_without_hyphen = str.gsub( /-/, '' )
      where( replaced_string_arel_attribute( :fax, '-', '' ).like( "%#{ fax_without_hyphen }%" ) )
    }

  end

end
