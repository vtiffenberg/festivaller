require 'rails_helper'

RSpec.describe Pass, type: :model do

  let!(:s) { Season.make }
  describe 'pass for event' do

    it "should return correct passes" do
      p1 = Pass.make season: s
      p2 = Pass.make season: s
      e1 = Event.make season: s
      e2 = Event.make season: s
      p1.events << e1
      p2.events << e2

      expect(Pass.for_event(e1).to_a).to eq([p1])
    end
  end

  describe "find by name" do

    it "should find legacy hardcoded passes" do
      p1 = Pass.make season: s, name: "festival completo"
      expect(Pass.find_by_name("Pase festival!")).to eq(p1)
    end

    it "should return nil if a la carte" do
      p = Pass.make season: s, name: "festival completo"
      expect(Pass.find_by_name("A la carte")).to be_nil
    end

    it "should find passes by exact name" do
      p1 = Pass.make season: s, name: "Open [Para todo los niveles - sin audición]"
      expect(Pass.find_by_name("Open [Para todo los niveles - sin audición]")).to eq(p1)
    end

    # Aspirational
    # it "should find passes by text set by user" do
    # end

  end

  describe 'show current season' do
    it 'scope should return only passes for current' do
      s2 = Season.make current: false
      p1 = Pass.make season: s
      p2 = Pass.make season: s2

      expect(Pass.current.to_a).to eq([p1])
    end

    it "should be the default" do
      s2 = Season.make current: false
      p1 = Pass.make season: s
      p2 = Pass.make season: s2

      expect(Pass.all.to_a).to eq([p1])
    end
  end

end
