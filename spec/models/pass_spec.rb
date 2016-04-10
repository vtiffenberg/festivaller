require 'rails_helper'

RSpec.describe Pass, type: :model do

  describe 'pass for event' do

    it "should return correct passes" do
      p1 = Pass.make
      p2 = Pass.make
      e1 = Event.make
      e2 = Event.make
      p1.events << e1
      p2.events << e2

      expect(Pass.for_event(e1).to_a).to eq([p1])
    end
  end

end
