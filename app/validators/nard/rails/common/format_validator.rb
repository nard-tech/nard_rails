class Nard::Rails::Common::FormatValidator < ActiveModel::EachValidator

  def validate_each( record, attribute, value )
    if invalid?(value)
      raise error_class
    end

  rescue Nard::Rails::Common::ModelFormatError => e
    record.errors.add( attribute, e.message )
  end

  private

  def invalid?(value)
    exec_validation?(value) and !(match_to_regexp(value))
  end

  def exec_validation?(value)
    !(value.blank? and options[:allow_blank]) and !(value.nil? and options[:allow_nil])
  end

  def match_to_regexp(value)
    valid_regexp === value
  end

  def valid_regexp
    raise 'Over-ride in sub-classes.'
  end

  def error_class
    raise 'Over-ride in sub-classes.'
  end

end
