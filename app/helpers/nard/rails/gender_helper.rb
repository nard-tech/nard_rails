module Nard::Rails::GenderHelper

  def genders
    h = Hash.new
    I18n.t('genders').each.with_index(1) do | (k,v), i |
      h[k.to_sym] = i
    end
    h
  end

  def genders_in_select_box
    I18n.t('genders').map { |k,v| [v,k] }
  end

end
