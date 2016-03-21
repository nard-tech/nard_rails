module Nard::Rails::ModelExt::Scopes::General

  extend ActiveSupport::Concern

  included do

    scope :blank, -> ( field ) {
      where( arel_table[ field ].eq( nil ).or( arel_table[ field ].eq( '' ) ) )
    }

    scope :present, -> ( field ) {
      where.not( arel_table[ field ].eq( nil ).or( arel_table[ field ].eq( '' ) ) )
    }

  end

end
