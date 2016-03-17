# 文字数を確認するクラス
class Nard::Rails::Text::LengthValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless (value.blank? and options[:allow_blank]) or (value.nil? and options[:allow_nil])

      simple_text = ::ApplicationController.helpers.sanitize( value )

      if options[:less_than_or_equal_to].present?
        unless simple_text <= options[:less_than_or_equal_to]
          raise Nard::Rails::Text::Length::LessThanOrEqualToErrorError.new( record, attribute, :less_than_or_equal_to, options[:less_than_or_equal_to] )
        end

      elsif options[:less_than].present?
        unless simple_text < options[:less_than]
          raise Nard::Rails::Text::Length::LessThanErrorError.new( record, attribute, :less_than, options[:less_than] )
        end
      end

      if options[:greater_than_or_equal_to].present?
        unless simple_text >= options[:greater_than_or_equal_to]
          raise Nard::Rails::Text::Length::GraterThanOrEqualToError.new( record, attribute, :greater_than_or_equal_to, options[:greater_than_or_equal_to] )
        end

      elsif options[:greater_than].present?
        unless simple_text > options[:greater_than]
          raise Nard::Rails::Text::Length::GraterThanError.new( record, attribute, :greater_than, options[:greater_than] )
        end
      end

    end

  rescue Nard::Rails::Text::Length::CommonError => e
    record.errors.add( e.field, e.message )
  end

end
