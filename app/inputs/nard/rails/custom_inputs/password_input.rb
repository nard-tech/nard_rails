module Nard::Rails::CustomInputs

  class PasswordInput < SimpleForm::Inputs::PasswordInput
    def input(wrapper_options=nil)
      set_minimum_password_length
      super
    end

    private

    def set_minimum_password_length
      minimum_length = options[:minimum_password_length]
      if minimum_length.present?
        options.merge!( hint: ApplicationController.helpers.t( 'devise.pages.registrations.new.messages.password_length' , length: minimum_length ) )
        options.delete( :minimum_password_length )
      end
    end

  end

end
