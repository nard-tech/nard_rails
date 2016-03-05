module Nard::Rails::ModelExt::Tweet

  extend ActiveSupport::Concern

  included do

    [ :api_configs, :tweet_service_class ].each do | method_name |
      delegate method_name, to: :account, prefix: true
    end

    [ :tweet_formatted, :tweet_length, :valid_tweet_length? ].each do | method_name |
      delegate method_name, to: :decorate
    end

    delegate :exec_tweet!, to: :tweet_service_instance

  end

  def media_file_obj
    nil
  end

  def has_media_file?
    false
  end

  def options
    h = {}
    h = h.merge( geo_tag_option )
    h
  end

  private

  def has_geo_info?
    false
  end

  def geo_tag_option
    ( has_geo_info? ? geo_tag.to_twitter_options : {} )
  end

  def tweet_service_instance
    account_tweet_service_class.new(self)
  end

end
