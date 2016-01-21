# @note
#   ApplicationHelper って、app ごとに定義する必要ある？
#   その app 特有の処理は decorator で完結すると思うんだけど
# @todo
#   note の件について考察
module Nard::Rails::ApplicationHelper

  def body_data_attrs
    {
      ctrl: controller.controller_path.gsub(/\//, '-').dasherize,
      action: action_name.dasherize
    }
  end

end
