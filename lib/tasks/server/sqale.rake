require 'fileutils'

module Sqale
  class EnvironmentError < ::StandardError
  end
end


namespace :sqale do
  namespace :app do

    desc 'Restart application on Sqale'
    task :restart do
      # @see https://sqale.jp/support/manual/faq-technical#app-restart

      begin
        raise Sqale::EnvironmentError unless Rails.application.on_sqale?

        system( '/etc/init.d/app restart' )

      rescue Sqale::EnvironmentError => e
        puts e.class
        nil
      end
    end

    namespace :log do

      namespace :sqale do
        # Sqale 実行内容の表示
        # @see https://sqale.jp/projects/xxxx/operation
        desc 'Show logs of Sqale'
        task :show do
          system( 'cat /var/log/sqale.log')
        end
      end

      namespace :production do
        # 標準ログの表示
        # @see http://qiita.com/mimi_nary/items/77036226de4bd47493fd
        desc 'Show logs of production'
        task :show do
          system( 'cat /home/sqale/current/log/production.log' )
        end
      end

      namespace :stderr do
        # エラー内容の表示
        # @see https://sqale.jp/support/manual/faq-technical#app-log
        desc 'Show logs of stderr'
        task :show do
          system( 'cat /var/log/app/stderr.log' )
        end
      end

      namespace :stdout do
        # 標準出力の内容の表示
        # @see https://sqale.jp/support/manual/faq-technical#app-log
        desc 'Show logs of stdout'
        task :show do
          system( 'cat /var/log/app/stdout.log' )
        end
      end

    end

  end

  namespace :postinstall do

    # 画像ディレクトリの処理
    # @see https://sqale.jp/support/manual/faq-technical#avoid-disappearing-image
    # @see https://gist.github.com/banyan/4943864
    desc "Process 'upload' directory on 'postinstall'"
    task :process_upload_dir do
      begin
        raise Sqale::EnvironmentError unless Rails.application.on_sqale?

        path = "#{ENV['HOME']}/current/public/uploads"

        if File.directory?(path)
          FileUtils.mv(path, "#{path}.old")
        elsif File.symlink?(path)
          FileUtils.rm(path)
        end

        FileUtils.symlink("#{ENV['HOME']}/uploads", path)

      rescue Sqale::EnvironmentError => e
        puts e.class
        nil
      end
    end

    # 'Whenever' による Crontab の設定
    desc 'Update Cron settings'
    task :update_cron do
      begin
        raise Sqale::EnvironmentError unless Rails.application.on_sqale?

        Dir.chdir("#{ENV['HOME']}/current")
        system('bundle exec whenever --update-crontab')

      rescue Sqale::EnvironmentError => e
        puts e.class
        nil
      end

    end

  end

  namespace :tmp_dir do
    desc 'Reset tmp dir'
    task reset: :environment do
      begin
        raise Sqale::EnvironmentError unless Rails.application.on_sqale?

        Dir.glob( "#{ Rails.root }/public/uploads/tmp/**/**.*" ).sort.each do | file |
          File.delete(file)
        end

      rescue Sqale::EnvironmentError => e
        puts e.class
        nil
      end
    end
  end

end
