module Nard::Rails::DecoratorExt::ErrorMessages

  # @!group Instance methods - Rendering

  # @todo listener gohobi
  def render_error_messages
    if object.errors.any?
      title = '以下の内容をご確認の上、もう一度送信してください。'
      # title = "#{object.errors.count}件のエラーがあります。"
      # title = "#{pluralize(object.errors.count, "error")} prohibited this pack_area from being saved:"

      h.render(partial: 'nard/rails/shared/errors', locals: {object: object, title: title, error_messages: error_messages})
    end
  end

  # @!endgroup

  private

  # @!group Private instance methods - Error messages

  def error_messages
    error_msgs = []
    error_msg_when_failed_to_update = Settings::Static.messages.failed_to_update

    if object.errors.any?
      object.errors.full_messages.each do | msg |
        unless msg == error_msg_when_failed_to_update
          error_msgs << msg
        end
      end
      if object.errors.full_messages.include?(error_msg_when_failed_to_update)
        error_msgs << error_msg_when_failed_to_update
      end
    end
    error_msgs
  end

  # @!endgroup

end
