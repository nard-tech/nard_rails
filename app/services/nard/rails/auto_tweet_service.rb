class Nard::Rails::AutoTweetService

  def initialize( twitter_account, settings )
    @twitter_account = twitter_account
    @settings = settings
    set_twitter_auto_post_id
  end

  def exec!
    twitter_auto_post.exec_tweet!
  end

  private

  def set_twitter_auto_post_id
    if @settings.present? and @settings === /\A\d+\Z/
      @twitter_auto_post_id = @settings.to_i
      @settings = nil
    end
  end

  def has_auto_post_id?
    @twitter_auto_post_id.present?
  end

  def twitter_auto_post
    has_auto_post_id? ? twitter_auto_post_by_id : twitter_auto_post_by_settings
  end

  def twitter_auto_post_by_id
    @twitter_account.auto_posts.includes(:hashtags).find( @twitter_auto_post_id )
  end

  def twitter_auto_post_by_settings
    @twitter_account.auto_posts.includes(:hashtags).sample
  end

  alias :__twitter_auto_post_by_settings__ :twitter_auto_post_by_settings

end
