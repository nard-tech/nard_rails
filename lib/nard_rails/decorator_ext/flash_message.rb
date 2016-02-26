# flash からの情報を取得して利用するメソッドを格納するモジュール
module Nard::Rails::DecoratorExt::FlashMessage

  extend ActiveSupport::Concern

  module ClassMethods

    # @!group Rendering

    def render_msg_on_index_page(_flash)
      if _flash['status'] == 'deleted'
        h.content_tag(:p, _flash['msg'], class: [:msg, 'msg--remark'])
      end
    end

    # @!endgroup

  end

  # @!group Instance methods - Messages

  def msg_after_deleted
    "#{ model_name_to_display }「#{ main_value }」を削除しました。"
  end

  # @!endgroup

  private

  # @!group Private instance methods - Rendering

  def render_msg_on_show_page(_flash)
    if _flash['status'].present?
      msg_base = msg_base_dict_on_show_page[ _flash['status'].to_sym ]
      classe_names = [:msg]
      classe_names << msg_class_on_show_page[ _flash['status'].to_sym ]

      if msg_base.present? and classe_names.present?
        msg = "#{ model_name_to_display }「#{ main_value }」#{msg_base}"
        h.content_tag(:p, msg, class: classe_names)
      end
    end
  end

  # @!group Private instance methods - Messages

  def msg_base_dict_on_show_page
    {
      created: 'が作成されました。',
      updated: 'が更新されました。',
      delete_error: 'を削除できませんでした。'
    }
  end

  def msg_class_on_show_page
    {
      created: 'msg--notice',
      updated: 'msg--notice',
      delete_error: 'msg--remark'
    }
  end

  # @!endgroup

end
