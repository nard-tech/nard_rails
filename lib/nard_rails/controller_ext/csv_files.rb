# Csv 出力を行うメソッドを格納するモジュール
module Nard::Rails::ControllerExt::CsvFiles

  extend ActiveSupport::Concern

  included do

    # @!group Filters before action - Set variables (collection - csv)

    before_action :set_csv_generator, only: :csv

    # @!endgroup

  end

  def csv
    send_data(@csv_generator.render, type: @csv_generator.type, filename: @csv_generator.filename)
  end

  private

    # @!group Before action - Set variables (collection - csv)

  def set_csv_generator
    @csv_generator = DrsCloud::CsvGenerator.new( all_collection )
  end

  # @!endgroup

end
