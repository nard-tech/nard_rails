class Nard::Rails::ParamsService

  def self.get(h)
    self.new(h).process.get
  end

  def initialize(h)
    @h = h
  end

  def get
    unless Rails.env.production?
      puts "#{ self.class.name }\#get"
      puts @h.to_s
    end

    @h
  end

  def process
    raise NotImplementedError
  end

end
