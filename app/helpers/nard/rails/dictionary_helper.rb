module Nard::Rails::DictionaryHelper

  # @!group Dictionary

  def t_dict( ref )
    factory = Nard::Rails::DictionaryService.new( ref )
    factory.to_s
  end

  def genders
    { male: 1, female: 2 }
  end

  # @!endgroup

end
