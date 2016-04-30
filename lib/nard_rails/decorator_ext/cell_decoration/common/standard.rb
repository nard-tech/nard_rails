class Nard::Rails::DecoratorExt::CellDecoration::Common::Standard

  def initialize(v, decorator)
    @decorator = decorator

    if v.instance_of?(Hash)
      raise ArgumentError unless v.length == 1

      @attribute = v.keys.first
      @options = v.values.first
    else
      @attribute = v
      @options = {}
    end
  end

  attr_reader :decorator, :attribute, :options

  private

  def field_in_db
    case @options[:in_db]
    when nil
      @attribute
    when false
      nil
    else
      @options[:in_db]
    end
  end

end
