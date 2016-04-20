module Nard::Rails::ControllerExt::SetCollection

  private

  def all_collection
    raise NotImplementedError
  end

  # @!group Before action - Set variables (collection)

  def set_all_collection
    raise NotImplementedError
  end

  # @!endgroup


end
