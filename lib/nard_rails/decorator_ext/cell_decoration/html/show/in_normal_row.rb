# 単一のモデルの各フィールドの情報を表示するリストの各行の値を扱うクラス
class Nard::Rails::DecoratorExt::CellDecoration::Html::Show::InNormalRow < Nard::Rails::DecoratorExt::CellDecoration::Common::InNormalRow

  include Nard::Rails::DecoratorExt::CellDecoration::Common::WithColumn

  def object_class
    @decorator.class.object_class
  end

  def ignored?
    @attribute.to_s == 'deleted_at' and displayed_value.blank?
  end

  def render
    h.content_tag( :tr, class: class_names_of_tr ) {
      td_ary = []
      td_ary << h.content_tag( :td, label, class: 'label-cell' )
      td_ary << h.content_tag( :td, displayed_value, class: class_names_of_value_cell )
      td_ary.join.html_safe
    }
  end

  private

  def class_names_of_tr( default = nil )
    ary = ( default.present? ? [default].flatten : [] )
    ary << @attribute.to_s.dasherize
    ary
  end

  def class_names_of_value_cell(default = nil)
    ary = ( default.present? ? [default].flatten : [] )
    if number?
      ary << 'text-right'
    end
    ary
  end

end
