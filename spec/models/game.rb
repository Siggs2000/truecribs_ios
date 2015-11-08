describe 'Game' do

  before do
    class << self
      include CDQ
    end
    cdq.setup
  end

  after do
    cdq.reset!
  end

  it 'should be a Game entity' do
    Game.entity_description.name.should == 'Game'
  end
end
