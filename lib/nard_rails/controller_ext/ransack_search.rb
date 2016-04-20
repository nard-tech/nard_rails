module Nard::Rails::ControllerExt::RansackSearch

  extend ActiveSupport::Concern

  included do

    before_action :set_params_for_search, only: [ :index, :csv ]
    before_action :set_search_engine, only: [ :index, :csv ]

  end

  private

  def set_params_for_search
    raise NotImplementedError
  end

  def set_search_engine
    raise NotImplementedError
  end

end
