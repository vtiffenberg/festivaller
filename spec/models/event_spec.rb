require 'rails_helper'

RSpec.describe Event, type: :model do

  describe "registrants" do

    let!(:s) { Season.make }
    let(:event) { Event.make }
    let(:pass) { Pass.make }

    before(:each) do
      pass.events << event
      3.times {|n| Registrant.make pass: pass}
    end

    it "should be added for 1 pass" do
      expect(event.registrants).to eq(3)
    end

    it "should be added for multiple passes" do
      new_pass = Pass.make
      new_pass.events << event
      Registrant.make pass: new_pass
      expect(event.registrants).to eq(4)
    end

    describe 'show current season' do
      it 'scope should return only passes for current' do
        s2 = Season.make current: false
        e2 = Event.make season: s2

        expect(Event.current.to_a).to eq([event])
      end

      it "should be the default" do
        s2 = Season.make current: false
        e2 = Event.make season: s2

        expect(Event.all.to_a).to eq([event])
      end
    end

  end
end
