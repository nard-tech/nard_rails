namespace :twitter do

  desc 'Tweet automatically'
  task :auto_tweet, [:account_name, :setting] => :environment do |t, args|
    account_name = args[:account_name]
    settings = args[:setting]

    twitter_account = TwitterAccount.find_by( name: account_name )

    AutoTweetService.new( twitter_account, settings ).exec!
  end

end
