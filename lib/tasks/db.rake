namespace :db do

  namespace :mysql do

    namespace :on_development do

      desc 'MySQL のバックアップ'
      task dump: :environment do
        config   = Rails.configuration.database_configuration
        username = config[Rails.env]['username']
        password = config[Rails.env]['password']
        host = config[Rails.env]['host']
        database = config[Rails.env]['database']
        socket = config[Rails.env]['socket']

        system( "mysqldump -u#{ username } -p#{ password } -S#{ socket } #{ database } > dump.sql" )
      end

      desc 'MySQL の復元'
      task :restore, [:dump_filename] => :environment do |t, args|
        config   = Rails.configuration.database_configuration
        username = config[Rails.env]['username']
        password = config[Rails.env]['password']
        host = config[Rails.env]['host']
        database = config[Rails.env]['database']
        socket = config[Rails.env]['socket']

        dump_filename = ( args[:dump_filename].present? ? args[:dump_filename] : 'dump.sql' )

        system( "mysql -u#{ username } -p#{ password } -S#{ socket } #{ database } < #{ dump_filename }" )
      end

    end

    namespace :on_production do

      desc 'dump ファイルの作成'
      task :dump, [:time] => :environment do |t, args|
        config   = Rails.configuration.database_configuration
        username = config[Rails.env]['username']
        password = config[Rails.env]['password']
        host = config[Rails.env]['host']
        database = config[Rails.env]['database']

        time = ( args[:time].present? ? args[:time] : Time.now.strftime('%Y%m%d_%H%M%S') )

        system("mysqldump -u#{ username } -p#{ password } -h#{ host } #{ database } > mysql_#{time}.dump")
      end

      desc 'S3 へバックアップ'
      task dump_and_send_to_s3: :environment do
        time = Time.now.strftime('%Y%m%d_%H%M%S')

        s3_bucket = Settings::Static.s3.bucket
        s3_directory = Settings::Static.s3.directory

        Rake::Task['db:mysql:on_production:dump'].invoke(time)
        system("s3cmd put mysql_#{ time }.dump s3://#{ s3_bucket }/#{ s3_directory }/mysql_#{ time }.dump")
        File.delete( "mysql_#{ time }.dump" )
      end

    end

  end

end
