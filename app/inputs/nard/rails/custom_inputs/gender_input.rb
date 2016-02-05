module Nard::Rails::CustomInputs

  class GenderInput < SimpleForm::Inputs::CollectionSelectInput
    def input(wrapper_options)
      super
    end
  end

end
