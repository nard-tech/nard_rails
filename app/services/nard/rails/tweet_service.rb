class Nard::Rails::TweetService

  LIMIT_LENGTH = 140

  def initialize( auto_post )
    @auto_post = auto_post

    inspect_account_api_configs
    _account_api_configs = account_api_configs

    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = _account_api_configs[:consumer_key]
      config.consumer_secret = _account_api_configs[:consumer_secret]
      config.access_token = _account_api_configs[:access_token]
      config.access_token_secret = _account_api_configs[:access_token_secret]
    end
  end

  attr_reader :auto_post

  [ :tweet_length, :valid_tweet_length?, :tweet_formatted ].each do | method_name |
    delegate method_name, to: :auto_post
  end

  [ :id, :media_object, :options ].each do | method_name |
    delegate method_name, to: :auto_post, prefix: true
  end

  def exec_tweet!
    puts 'Nard::Rails::TweetService#exec_tweet!'

    puts "id: #{ auto_post_id }"
    puts "length: #{ tweet_length }"
    puts @client.inspect

    raise LengthError.new( @auto_post ) unless valid_tweet_length?

    puts tweet_formatted

    begin
      if @auto_post.has_media?
        @client.update_with_media( tweet_formatted, auto_post_media_object, auto_post_options )
      else
        @client.update( tweet_formatted, auto_post_options )
      end

    rescue Twitter::Error::Forbidden => e
      [ e.class, e.message, e.backtrace, '', tweet_formatted, "(#{ tweet_formatted.length } characters)", '' ].each do |c|
        puts c
      end
      raise e

    rescue => e
      [ e.class, e.message, e.backtrace ].each do |c|
        puts c
      end
      @client.update( tweet_formatted, auto_post_options )
    end

  rescue LengthError => e
    Rails.logger.error << e.message
  end

  private

  def inspect_account_api_configs
    puts account_api_configs.to_s
  end

  def account_api_configs
    @auto_post.account_api_configs
  end

end
