require 'rails_helper'

RSpec.describe Pass, type: :model do

  describe 'pass for event' do

    it "should return correct passes" do
      s = Season.make
      p1 = Pass.make season: s
      p2 = Pass.make season: s
      e1 = Event.make season: s
      e2 = Event.make season: s
      p1.events << e1
      p2.events << e2

      expect(Pass.for_event(e1).to_a).to eq([p1])
    end
  end

  describe 'show current season' do
    it 'scope should return only passes for current' do
      s = Season.make
      s2 = Season.make current: false
      p1 = Pass.make season: s
      p2 = Pass.make season: s2

      expect(Pass.current.to_a).to eq([p1])
    end

    it "should be the default" do
      s = Season.make
      s2 = Season.make current: false
      p1 = Pass.make season: s
      p2 = Pass.make season: s2

      expect(Pass.all.to_a).to eq([p1])
    end
  end

end
