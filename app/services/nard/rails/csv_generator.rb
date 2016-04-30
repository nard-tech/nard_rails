require 'kconv'
require 'csv'

# Csv ファイルに書き出す文字列の生成を行うクラス
class Nard::Rails::CsvGenerator

  def initialize(datum, encoding: 'windows-31j', type: 'text/csv; charset=shift_jis')
    @datum = datum
    @encoding = encoding
    @type = type
  end

  def render
    ::CSV.generate( row_sep: "\r\n", force_quotes: true , &proc_for_render ).encode( @encoding )
  end

  def to_options
    { type: @type, filename: filename }
  end

  private

  def header
    @datum.model.decorator_class.header_of_csv
  end

  def filename
    "#{ @datum.model.name.underscore.pluralize }_#{ Time.now.strftime( "%Y%m%d%H%M%S" ) }.csv"
  end

  def proc_for_render
    Proc.new do | csv |
      csv << header
      @datum.each do | data |
        csv << data.decorate.to_csv
      end
    end
  end

end
