class Nard::Rails::YoutubeService

  URL_REGEXP = /\Ahttps:\/\/(?:youtu\.be\/|www\.youtube\.com\/(?:watch\?v=|embed\/))/
  ID_REGEXP = /\A([^&\?]+)/

  def initialize( model, field )
    @model = model
    @field = field
  end

  def embed_url
    unless url.present?
      return nil
    end

    unless youtube_link?
      return nil
    end

    "https://www.youtube.com/embed/#{ youtube_id }"
  end

  def youtube_link?
    URL_REGEXP === url
  end

  private

  def url
    @model.send( @field )
  end

  def youtube_id
    url.gsub( URL_REGEXP, '' ).scan( ID_REGEXP ).flatten.first
  end

  def formatted_url
    "https://www.youtube.com/watch?v=#{ youtube_id }"
  end

  def set_formatted_url
    unless youtube_link?
      return
    end

    @model.assign_attributes( { @field => formatted_url } )
  end

end
