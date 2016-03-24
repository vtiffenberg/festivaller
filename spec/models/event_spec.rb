require 'rails_helper'

RSpec.describe Event, type: :model do

  describe "registrants" do

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

  end
end
