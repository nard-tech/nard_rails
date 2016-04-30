class Nard::Rails::DecoratorExt::CellDecoration::Common::InHeaderRow < Nard::Rails::DecoratorExt::CellDecoration::Common::Standard

  include Nard::Rails::DecoratorExt::CellDecoration::Common::WithColumn

  private

  def number?
    false
  end

  def object_class
    @decorator.object_class
  end

end
