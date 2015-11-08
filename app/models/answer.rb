class Answer < CDQManagedObject
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
      Answer.new(params).tap do |answer|
        answer.save
      end
    end

    def find(id_or_params)
    end

    def all
      Answer.find(:all)
    end
  end
end
