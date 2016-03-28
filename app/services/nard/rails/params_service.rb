class Nard::Rails::ParamsService

  def self.get(h)
    self.new(h).process.get
  end

  def initialize(h)
    @h = h
  end

  def get
    @h
  end

  def process
    raise NotImplementedError
  end

end
