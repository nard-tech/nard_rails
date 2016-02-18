module Nard::Rails::ModelExt::Youtube

  extend ActiveSupport::Concern

  included do
    delegate :embed_url, to: :youtube_service, prefix: :youtube
  end

  def has_youtube_link?
    youtube_service.youtube_link?
  end

  private

  def youtube_service
    Nard::Rails::YoutubeService.new( self, :link )
  end

  def set_youtube_formatted_url
    youtube_service.send( :set_formatted_url )
  end

end
