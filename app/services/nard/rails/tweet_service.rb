class Nard::Rails::TweetService

  LIMIT_LENGTH = 140

  CHARACTERS_REDUCED_BY_IMAGE = 23
  CHARACTERS_REDUCED_BY_URL = 22

  def initialize( posted_info )
    @posted_info = posted_info

    inspect_account_api_configs unless Rails.env.production?
    _account_api_configs = account_api_configs

    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = _account_api_configs[:consumer_key]
      config.consumer_secret = _account_api_configs[:consumer_secret]
      config.access_token = _account_api_configs[:access_token]
      config.access_token_secret = _account_api_configs[:access_token_secret]
    end
  end

  attr_reader :posted_info

  [ :tweet_length, :valid_tweet_length?, :tweet_formatted ].each do | method_name |
    delegate method_name, to: :posted_info
  end

  [ :id, :media_file_obj, :options, :has_media_file? ].each do | method_name |
    delegate method_name, to: :posted_info, prefix: true
  end

  def exec_tweet!
    unless Rails.env.production?
      puts 'Nard::Rails::TweetService#exec_tweet!'

      puts "id: #{ posted_info_id }"
      puts "length: #{ tweet_length }"
      puts @client.inspect
    end

    raise LengthError.new( @posted_info ) unless valid_tweet_length?

    puts tweet_formatted unless Rails.env.production?

    begin
      if posted_info_has_media_file?
        @client.update_with_media( tweet_formatted, posted_info_media_file_obj, posted_info_options )
      else
        @client.update( tweet_formatted, posted_info_options )
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
      @client.update( tweet_formatted, posted_info_options )
    end

  rescue LengthError => e
    Rails.logger.error << e.message
  end

  private

  def inspect_account_api_configs
    puts account_api_configs.to_s
  end

  def account_api_configs
    @posted_info.account_api_configs
  end

end
