require 'kaminari'

# Kaminari によるページネーションを扱うクラス
module Nard::Rails::ControllerExt::KaminariPages

  private

  def page_number
    ( has_page_number? ? params[:page].to_i : 1 )
  end

  def has_invalid_page_number?(collection, action_name)
    if has_page_number?
      unless max_page_number( collection ) >= page_number
        redirect_to(controller: controller_name, action: action_name, page: 1, status: :see_other)
        return true
      end
    end

    return false
  end

  def has_page_number?
    params[:page].present?
  end

  def max_page_number( collection )
    ( collection.count / models_per_page ) + 1
  end

  def collection_for_pagination(collection)
    collection.page(page_number).per( models_per_page )
  end

  def models_per_page
    Kaminari.config.default_per_page
  end

end
