module Nard::Rails::ModelExt::TableStatus

  extend ActiveSupport::Concern

  module ClassMethods

    def table_status
      ::ActiveRecord::Base.connection.select_one(  "SHOW TABLE STATUS like '#{ name.underscore.pluralize }'" )
    end

  end

end
