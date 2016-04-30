# Csv ファイルに書き出す文字列の生成を行うクラス
class Nard::Rails::CsvGenerator

  def initialize(datum, encode: 'windows-31j', type: 'text/csv; charset=shift_jis')
    @datum = datum
    @encode = encode
    @type = type
  end

  attr_reader :type

  def render
    require 'kconv'
    require 'csv'

    result = ''

    result << header
    result << "\r"

    contents.each do | content |
      result << content
      result << "\r"
    end

    result.encode(@encode)
  end

  def to_options
    { type: @type, filename: filename }
  end

  private

  def header
    @datum.model.decorator_class.header_of_csv.join(',')
  end

  def contents
    @datum.map { | data | data.decorate.to_csv }
  end

  def filename
    "#{ @datum.model.name.underscore.pluralize }_#{ Time.now.strftime( "%Y%m%d%H%M%S" ) }.csv"
  end

end
