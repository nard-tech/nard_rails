class Nard::Rails::TweetService::LengthError < ::StandardError

  def initialize( auto_post )
    @auto_post = auto_post
  end

  attr_reader :auto_post

  delegate :tweet, to: :auto_post
  delegate :tweet_length, to: :auto_post

  def message
    "ERROR: Nard::Rails::TweetService#exec_tweet!" + message_ary.map { | str | "  #{ str }" }.join( ' ' )
  end

  private

  def message_ary
    ary = "This post has #{ tweet_length } characters."
    ary << ""
    ary << "Tweet:"
    ary << ""
    ary << tweet
    ary
  end

end
