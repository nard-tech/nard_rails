module Nard::Rails::DictionaryHelper

  # @!group Dictionary

  # @see http://rails3try.blogspot.jp/2012/01/rails3-i18n.html
  def t_dict( label )
    # puts ""
    # puts label
    ary = label.split('.')
    # puts ary.to_s

    model = ary[0].camelize.constantize
    # puts "Model: #{model}"
    begin
      case ary.length
      when 1
        model.model_name.human
      when 2
        model.human_attribute_name( ary[1] )
      when 3
        # puts str = "activerecord.#{ ary[1].pluralize }.#{ ary[0] }.#{ ary[2] }"
        t( "activerecord.#{ ary[1].pluralize }.#{ ary[0].underscore }.#{ ary[2] }" )
      when 4
        case ary[1]
        when 'enumerize'
          t( "enumerize.#{ ary[0].underscore }.#{ ary[2] }.#{ ary[3] }" )
        when 'decorator'
          t( "activerecord.decorators.#{ ary[0].underscore }.#{ ary[2] }.#{ ary[3] }" )
        else
          raise Nard::Rails::DictionaryHelper::TDict::InvalidLabelError
        end
      else
        raise Nard::Rails::DictionaryHelper::TDict::InvalidLabelError
      end
    rescue Nard::Rails::DictionaryHelper::TDict::InvalidLabelError
      label
    end
  end

  # @!endgroup

end
