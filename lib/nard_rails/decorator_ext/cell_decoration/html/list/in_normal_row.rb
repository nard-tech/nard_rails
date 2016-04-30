# 複数のモデルの情報を表示するリストの各行の値を扱うクラス
class Nard::Rails::DecoratorExt::CellDecoration::Html::List::InNormalRow < Nard::Rails::DecoratorExt::CellDecoration::Common::InNormalRow

  include Nard::Rails::DecoratorExt::CellDecoration::Html::List::ClassNames

  private

  def optional_classes
    ary = []
    if @options[:class_names].present? and @options[:class_names].instance_of?(::Proc)
      ary << @options[:class_names].call(@decorator)
    end
    ary.flatten
  end

end
