module Nard::Rails::DecoratorExt::Master

  extend ActiveSupport::Concern

  module ClassMethods

    # @!group Class methods - Model

    def model_name_to_display
      self.object_class.model_name.human
    end

    # @!endgroup

  end

  # @!group Main value

  def main_value
    object.send(main_value_field)
  end

  def main_value_field
    :id
  end

  # @!group Instance methods - Model

  def model_name_to_display
    self.class.model_name_to_display
  end

  # @!endgroup

  private

  # @!group Private instance methods - Rendering

  def render_main_areas_on_show_page(_flash, options)
    ary = []

    ary << render_table_on_show_page(options)
    ary << render_btns_on_show_page(_flash, options)

    ary.join.html_safe
  end

  # @!endgroup

end
