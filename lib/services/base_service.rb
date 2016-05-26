class BaseService

  def self.call(*args)
    self.new(*args).call
  end

end
