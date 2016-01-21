# Csv 出力を行うメソッドを格納するモジュール
module Nard::Rails::ControllerExt::CsvFiles

  def list
    send_data(@csv_generator.render, type: @csv_generator.type, filename: @csv_generator.filename)
  end

end
