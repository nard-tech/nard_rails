module Nard::Rails::ControllerExt::Ability

  private

  def ability_property
    case params[:action].to_s
    when 'index', 'show'
      :read
    else
      params[:action].to_sym
    end
  end

end
