class Game < CDQManagedObject
  def initialize(params = {})
  end

  def update(params = {})
    self
  end

  def delete
  end

  def save
    true
  end

  class << self
    def create(params = {})
      Game.new(params).tap do |game|
        game.save
      end
    end

    def find(id_or_params)
    end

    def all
      Game.find(:all)
    end
  end
end
