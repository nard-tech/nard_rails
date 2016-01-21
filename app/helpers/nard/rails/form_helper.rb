module Nard::Rails::FormHelper

  def required_badge
    content_tag( :abbr, title: '必須' ) {
      content_tag( :span, '必須', class: [ 'badge', 'badge-required' ] )
    }
  end

end
