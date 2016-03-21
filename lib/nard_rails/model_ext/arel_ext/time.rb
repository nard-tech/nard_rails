module Nard::Rails::ModelExt::ArelExt::Time

  extend ActiveSupport::Concern

  included do

    def self.time_arel_attribute( field )
      AttributeWrapper.new( arel_table[field] )
    end

  end

end
