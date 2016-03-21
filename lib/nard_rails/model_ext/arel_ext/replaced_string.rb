module Nard::Rails::ModelExt::ArelExt::ReplacedString

  extend ActiveSupport::Concern

  included do

    def self.replaced_string_arel_attribute( field, from, to )
      AttributeWrapper.new( arel_table[field], from, to )
    end

  end

end
