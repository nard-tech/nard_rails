module Nard::Rails::KaminariHelper

  def paginate_at( position, items: nil )
    if items.present?
      _page_entries_info = page_entries_info( items )
      _page_entries_info.gsub!( /s(?=の \d+ - \d+ 件を表示中)/ , "" )

      content_tag( :div, class: [ 'paginate-infos', "paginate-links--#{ position }" ] ) {
        page_entries_info_html = content_tag( :p, _page_entries_info )
        paginate_html = paginate( items )

        page_entries_info_html + paginate_html
      }
    elsif position == :top
      content_tag( :p, "表示する情報はありません。" )
    end
  end

end
