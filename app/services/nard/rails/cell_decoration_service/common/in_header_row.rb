class Nard::Rails::CellDecorationService::Common::InHeaderRow < Nard::Rails::CellDecorationService::Common::Standard

  include Nard::Rails::CellDecorationService::Common::WithColumn

  private

  def number?
    false
  end

  def object_class
    @decorator.object_class
  end

end
