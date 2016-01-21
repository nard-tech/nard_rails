module Nard::Rails::DecoratorExt::ErrorMessages

  # @!group Instance methods - Rendering

  def render_error_messages
    if object.errors.any?
      title = "#{object.errors.count}件のエラーがあります。"
      # title = "#{pluralize(object.errors.count, "error")} prohibited this pack_area from being saved:"

      h.concat h.render(partial: 'shared/errors', locals: {title: title, error_msgs: error_messages})
    end
    nil
  end

  # @!endgroup

  private

  # @!group Private instance methods - Error messages

  def error_messages
    error_msgs = []
    if object.errors.any?
      object.errors.full_messages.each do | msg |
        unless msg == Settings::Static.msg_when_failing_update
          error_msgs << msg
        end
      end
      if object.errors.full_messages.include?(Settings::Static.msg_when_failing_update)
        error_msgs << Settings::Static.msg_when_failing_update
      end
    end
    error_msgs
  end

  # @!endgroup

end
