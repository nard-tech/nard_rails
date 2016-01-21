# 数値の桁数を確認するクラス
class Nard::Rails::Number::DigitsValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless (value.blank? and options[:allow_blank]) or (value.nil? and options[:allow_nil])

      if options[:less_than_or_equal_to].present?
        unless value < 10**( options[:less_than_or_equal_to] )
          raise Nard::Rails::Number::Digit::LessThanOrEqualToErrorError.new( record, attribute, :less_than_or_equal_to, options[:less_than_or_equal_to] )
        end

      elsif options[:less_than].present?
        unless value < 10**( options[:less_than] - 1 )
          raise Nard::Rails::Number::Digit::LessThanErrorError.new( record, attribute, :less_than, options[:less_than] )
        end
      end

      if options[:greater_than_or_equal_to].present?
        unless value >= 10**( options[:greater_than_or_equal_to] - 1 )
          raise Nard::Rails::Number::Digit::GraterThanOrEqualToError.new( record, attribute, :greater_than_or_equal_to, options[:greater_than_or_equal_to] )
        end

      elsif options[:greater_than].present?
        unless value >= 10**( options[:greater_than] )
          raise Nard::Rails::Number::Digit::GraterThanError.new( record, attribute, :greater_than, options[:greater_than] )
        end
      end

    end

  rescue Nard::Rails::Number::Digit::CommonError => e
    record.errors.add( e.field, e.message )
  end

end
