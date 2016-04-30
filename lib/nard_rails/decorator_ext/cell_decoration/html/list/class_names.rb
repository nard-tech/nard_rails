module Nard::Rails::DecoratorExt::CellDecoration::Html::List::ClassNames

  def class_names(default = nil)
    ary = ( default.present? ? [default].flatten : [] )
    ary << @attribute.to_s.dasherize
    if number?
      ary << 'text-right'
    end
    if optional_classes.present?
      optional_classes.each do |optional_class|
        ary << optional_class
      end
    end
    ary
  end

  private

  def optional_classes
    nil
  end

end
