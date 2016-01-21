class Nard::Rails::CellDecorationService::Common::InNormalRow < Nard::Rails::CellDecorationService::Common::Standard

  def displayed_value
    @decorator.send(@attribute)
  end

  private

  def number?
    if @options[:number].nil?
      field_in_db.present? and /^int/ === object_class.column_type(of: field_in_db)
    else
      @options[:number]
    end
  end

  def object_class
    @decorator.class.object_class
  end

end
