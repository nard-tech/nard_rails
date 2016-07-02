module Nard::Rails::TelephoneHelper

  # @!group Regexp

  def tel_regexp( options = {} )
    options = normalize_tel_regexp_options( options )
    regexp_str = ''

    unless options.delete( :allow_prefix )
      regexp_str += '\A'
    end

    regexp_str_for_free_call = '0120-?(?:\d-?){5}\d'

    if options.delete( :require_area_code )
      # regexp_str_for_normal_number = /(?:(?:0\d{1}-?\d{4}|0\d{2}-?\d{3}|0\d{3}-?\d{2}|0\d{4}-?\d{1})-?\d{4}|0\d{2}-?\d{4}-?\d{4})/
      regexp_str_for_normal_number = '(?:(?:0\d{1}-?\d{4}|0\d{2}-?\d{3}|0\d{3}-?\d{2}|0\d{4}-?\d{1})-?\d{4}|0\d{2}-?\d{4}-?\d{4})'
    else
      regexp_str_for_normal_number = /(?:(?:0\d{1}-?\d{4}|0\d{2}-?\d{3}|0\d{3}-?\d{2}|0\d{4}-?\d{1})|0\d{2}-?\d{4}|\d{1,4})-?\d{4}/
      regexp_str_for_normal_number = '(?:(?:0\d{1}-?\d{4}|0\d{2}-?\d{3}|0\d{3}-?\d{2}|0\d{4}-?\d{1})|0\d{2}-?\d{4}|\d{1,4})-?\d{4}'
    end

    if options.delete( :allow_free_call )
      regexp_str_for_free_call = '0120-?(?:\d-?){5}\d'

      regexp_str += '(?:'
      regexp_str += regexp_str_for_normal_number
      regexp_str += '|'
      regexp_str += regexp_str_for_free_call
      regexp_str += ')'
    else
      regexp_str += regexp_str_for_normal_number
    end


    unless options.delete( :allow_suffix )
      regexp_str += '\Z'
    end

    Regexp.new( regexp_str )
  end

  # @!endgroup

  private

  def normalize_tel_regexp_options( options )
    options = options.with_indifferent_access.dup
    options.slice!( :require_area_code, :allow_free_call, :allow_prefix, :allow_suffix )

    options.each do |k,v|
      raise ArgumentError, "value of options '#{k}' should be true, false or nil" unless v == true or v == false or v == nil
    end

    options[ :require_area_code ] = true if options[ :require_area_code ].nil?
    options[ :allow_free_call ] = true if options[ :allow_free_call ].nil?
    options[ :allow_prefix ] = false if options[ :allow_prefix ].nil?
    options[ :allow_suffix ] = false if options[ :allow_suffix ].nil?

    options
  end

end
