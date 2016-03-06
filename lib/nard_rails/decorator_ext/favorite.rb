module Nard::Rails::DecoratorExt::FavoriteButton

  def render_favorite_button( user, class_name, data_h = {} )
    if object.is_favored?( by: user )
      class_modified = 'favorite-btn--favored'
      title = 'クリックで解除'
      status = true
      icon_name = 'star'

      data_h.merge!( id: object.favorite( by: user ).id )
    else
      class_modified = 'favorite-btn--not-favored'
      title = 'クリックで追加'
      status = false
      icon_name = 'star-o'
    end

    data_h.merge!( status: status )

    h.content_tag( :div, id: "js-#{ class_name }", class: [ class_name, class_modified, :btn, 'btn-default' ], title: title, data: data_h ) {
      h.fa_icon( icon_name, text: 'お気に入り', class: "#{ class_name }__star", id: "js-#{ class_name }__star" )
    }
  end

end
