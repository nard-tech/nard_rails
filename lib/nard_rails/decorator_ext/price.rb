# 価格に関するフィールドを #number_to_currency によってカンマ付きの文字列に変換して返すメソッドを定義するモジュール
module Nard::Rails::DecoratorExt::Price

  extend ActiveSupport::Concern

  included do

    object_class.column_names.each do | field_name |
      if /(?:price|amount)/ === field_name and /^int/ === object_class.column_type( of: field_name )
        eval <<-DEF
          def #{ field_name }
            yen( :#{ field_name })
          end
        DEF
      end
    end

  end

  private

  def yen( *args )
    options = args.extract_options!
    _value = options.delete( :value )
    if _value.present?
      raise ArgumentError unless args.blank?
      v = _value
    else
      raise ArgumentError unless args.present? and args.length == 1
      field_name = args.shift
      v = object.send( field_name )
    end

    unless options[ :format ]
      options.merge!( format: "%n%u" )
    end

    unit = options[ :unit ]

    if unit == false
      options[ :unit ] = nil
    elsif unit.blank?
      options[ :unit ] = ' 円'
    end

    v.present? ? ApplicationController.helpers.number_to_currency( v,  options ) : ''
  end

end
