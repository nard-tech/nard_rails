module Nard::Rails::DictionaryHelper

  # @!group Dictionary

  def t_dict( ref )
    factory = Nard::Rails::DictionaryService.new( ref )
    factory.to_s
  end

  # @!endgroup

end
