require 'fileutils'

module Sqale
  class EnvironmentError < ::StandardError
  end
end


namespace :sqale do
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
