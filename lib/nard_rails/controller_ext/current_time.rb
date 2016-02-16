module Nard::Rails::ControllerExt::CurrentTime

  # @!group Before Action

  def set_current_time
    @current_time = ::Time.now
  end

  private :set_current_time

  # @!endgroup

end
