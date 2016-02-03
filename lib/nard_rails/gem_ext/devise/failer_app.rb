module Nard::Rails::GemExt::Devise::FailerApp

  def i18n_message(default = nil)
    message = warden_message || default || :unauthenticated

    if message.is_a?(Symbol)
      options = {}
      options[:resource_name] = scope
      options[:scope] = "devise.failure"
      options[:default] = [message]
      auth_keys = scope_class.authentication_keys
      keys = auth_keys.respond_to?(:keys) ? auth_keys.keys : auth_keys

      #--------

      # regexp = / ?または ?/
      keys = keys.map { |key|
        str = I18n.translate("activerecord.attributes.#{ scope }.#{ key }" )

        # if regexp === str
        #   str = str.gsub( regexp, '' )
        # end

        str
      }

      #--------

      options[:authentication_keys] = keys.join(I18n.translate(:"support.array.words_connector"))
      options = i18n_options(options)

      I18n.t(:"#{scope}.#{message}", options)
    else
      message.to_s
    end
  end

end
