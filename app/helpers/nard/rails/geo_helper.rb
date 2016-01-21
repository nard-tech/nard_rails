module Nard::Rails::GeoHelper

  # @!group Prefectures

  def jp_prefectures_for_enumerize
    h = Hash.new
    I18n.t('geo.prefectures').each do |k,v|
      h[ v[:name_e] ] = k
    end
    h
  end

  def jp_prefectures_in_select_box
    I18n.t('geo.prefectures').map { |k,v| [ v[:name] , v[:name_e] ] }
  end

  def jp_prefectures_in_select_box_for_search
    I18n.t('geo.prefectures').map { |k,v| [ v[:name] , k ] }
  end

  def select_pref( f , field_name , required: false )
    f.select( field_name, jp_prefectures_in_select_box  , { include_blank: true } , required: required , class: [ 'form-control' , 'pref' ] ) # prompt: "（都道府県）"
  end

  # @!endgroup

end
