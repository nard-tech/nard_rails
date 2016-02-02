module Nard::Rails::Devise::DictionaryHelper

  def t_devise( ref, options = {} )
    factory = Nard::Rails::Devise::DictionaryService.new( ref, options )
    factory.to_s
  end

end
