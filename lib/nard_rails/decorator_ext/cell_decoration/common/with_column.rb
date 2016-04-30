module Nard::Rails::DecoratorExt::CellDecoration::Common::WithColumn

  def initialize(v, decorator, column)
    @column = column
    super(v, decorator)
  end

  attr_reader :column

  def label
    ApplicationController.helpers.t_dict( "#{ object_class.name }.#{ @column }" )
  end

end
