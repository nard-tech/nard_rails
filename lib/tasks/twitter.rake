namespace :twitter do

  desc 'Tweet automatically'
  task :auto_tweet, [:user_name, :setting] => :environment do |t, args|
    user_name = args[:user_name]
    settings = args[:setting]

    twitter_account = TwitterAccount.find_by( user_name: user_name )

    if settings.present? and /\A\d+\Z/ === settings
      auto_post_id = settings.to_i
      twitter_auto_post = twitter_account.auto_posts.includes(:hashtags).find( auto_post_id )
    else
      twitter_auto_post = twitter_account.auto_posts.includes(:hashtags).sample
    end

    twitter_auto_post.exec_tweet!
  end

end
