namespace :server do
  namespace :sqale do
    namespace :postinstall do

      # 画像ディレクトリの処理
      # @see https://sqale.jp/support/manual/faq-technical#avoid-disappearing-image
      # @see https://gist.github.com/banyan/4943864
      desc "Process 'upload' directory on 'postinstall'"
      task :process_upload_dir do

        path = "#{ENV['HOME']}/current/public/uploads"

        if File.directory?(path)
          FileUtils.mv(path, "#{path}.old")
        elsif File.symlink?(path)
          FileUtils.rm(path)
        end

        FileUtils.symlink("#{ENV['HOME']}/uploads", path)
      end

      # 'Whenever' による Crontab の設定
      desc 'Update Cron settings'
      task :update_cron do

        Dir.chdir("#{ENV['HOME']}/current")
        system('bundle exec whenever --update-crontab')
      end

    end
  end
end
