module Nard::Rails::FormHelper

  def required_badge
    content_tag( :abbr, title: '必須' ) {
      content_tag( :span, '必須', class: [ 'badge', 'badge-required' ] )
    }
  end

  def showing_field( label_name, info, grid: { sm: 3 } )
    label_grid_classes = grid.map { |k,v| "col-#{k}-#{v}" }
    info_grid_classes = grid.map { |k,v| "col-#{k}-#{ 12 - v }" }

    content_tag( :div, class: [ :field, :row ] ) {
      concat content_tag( :div, label_name, class: [ 'showing-label', label_grid_classes ].flatten )
      concat content_tag( :div, info, class: info_grid_classes )
    }
  end

end
