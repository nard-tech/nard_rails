require 'kaminari'

# Kaminari によるページネーションを扱うクラス
module Nard::Rails::ControllerExt::KaminariPages

  private

  def page_number
    ( has_page_number? ? params[:page].to_i : 1 )
  end

  def has_invalid_page_number?(collection, action_name)
    if has_page_number?
      max_page_number = (collection.count / Kaminari.config.default_per_page) + 1
      unless max_page_number >= page_number
        redirect_to(controller: controller_name, action: action_name, page: 1, status: :see_other)
        return true
      end
    end

    return false
  end

  def has_page_number?
    params[:page].present?
  end

  def collection_for_pagination(collection)
    collection.page(page_number).per(Kaminari.config.default_per_page)
  end

end
