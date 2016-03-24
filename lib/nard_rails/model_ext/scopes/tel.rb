module Nard::Rails::ModelExt::Scopes::Tel

  include Nard::Rails::ModelExt::ArelExt::ReplacedString
  extend ActiveSupport::Concern

  included do

    scope :tel_search, -> ( str ) {
      tel_without_hyphen = str.gsub( /-/, '' )
      where( replaced_string_arel_attribute( :tel, '-', '' ).like( "%#{ tel_without_hyphen }%" ) )
    }

  end

end
