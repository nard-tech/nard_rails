module Nard::Rails::DecoratorExt::Tweet

  def tweet_formatted
    if valid_tweet_length?
      str = "#{ tweet_without_link_and_hashtags } #{ link_on_twitter }#{ tweet_hashtags }"
    elsif valid_tweet_length?( tweet_without_link_and_hashtags )
      str = tweet_shortened( "#{ tweet_without_link_and_hashtags } #{ link_on_twitter }#{ tweet_hashtags }" )
    else
      len = tweet_length( tweet_without_link_and_hashtags )
      exceeded_len = len - Nard::Rails::TweetService::LIMIT_LENGTH
      str = "#{ tweet_shortened( tweet_without_link_and_hashtags )[0..( - ( exceeded_len + 3 + 1 ) ) ] }... #{ link_on_twitter }"
    end

    str.gsub( / {2,}/, ' ' ).gsub( /\s+\Z/, '' )
  end

  def tweet_length( str = nil )
    str ||= ( tweet_without_link_and_hashtags + tweet_hashtags )

    len = str.length
    len += ( Nard::Rails::TweetService::CHARACTERS_REDUCED_BY_URL + 1 ) if has_link_on_twitter?
    len += Nard::Rails::TweetService::CHARACTERS_REDUCED_BY_IMAGE if has_media_file?
    len
  end

  def valid_tweet_length?( str = nil )
    tweet_length( str ) <= Nard::Rails::TweetService::LIMIT_LENGTH
  end

  private

  def has_link_on_twitter?
    link_on_twitter.present?
  end

  def link_on_twitter
    nil
  end

  def has_media_file?
    false
  end

  def tweet_shortened( str )
    str = str.gsub( /\s+\Z/, '' )

    while !( valid_tweet_length?( str ) )
      len = tweet_length( str )
      str = str.gsub( /\s+\Z/, '' )
      str = str.gsub( /(?<=。)[^\s]+?\Z/, '' )
      str = str.gsub( /\s+\#[^\s]+?\Z/, '' )
      str = str.gsub( /\s+\Z/, '' )
      break if len == tweet_length( str )
    end

    str.gsub( /\s+\Z/, '' )
  end

end
