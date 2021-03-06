require 'rails_helper'

RSpec.describe AttendanceController, type: :controller do

  let(:user) { User.make }
  let!(:s) { Season.make }
  before(:each) { sign_in user }

  describe "event happening" do

    it "should select an event" do
      e = Event.make date: DateTime.now - 1.hour, season: s
      expect(@controller.instance_eval{ event_happening_now }).to eq(e)
    end

    it "should select the last event happening" do
      Event.make date: (DateTime.now - 24.hours), season: s
      Event.make date: (DateTime.now - 12.hours), season: s
      e = Event.make date: (DateTime.now - 2.hours), season: s
      expect(@controller.instance_eval{ event_happening_now }).to eq(e)
    end

    it "should redirect to event if it is happening" do
      e = Event.make date: DateTime.now - 1.hour, season: s
      get :index

      expect(response).to redirect_to(event_attendance_path(e.id))
    end

    it "should show all events if it isn't" do
      e = Event.make date: DateTime.now + 2.hours, season: s
      get :index

      expect(response.status).to eq(200)
      expect(assigns(:events)).to eq([e])
    end

  end

  describe "event" do

    let!(:event) { Event.make date: DateTime.now - 2.hours, season: s }
    let!(:pass) { Pass.make season: s }
    let!(:other_pass) { Pass.make season: s }

    before(:each) do
      event.passes << pass
    end

    it "should load chosen event and passes for it" do
      get :event, id: event.id

      expect(assigns(:event)).to eq(event)
      expect(assigns(:passes_with_cover)).to eq([pass.id])
    end

    it "should load all registrants" do
      r1 = Registrant.make pass: pass, season: s
      r2 = Registrant.make pass: other_pass, season: s
      get :event, id: event.id

      regs = assigns(:registrants)
      expect(regs.length).to eq(2)
      first = regs.select{|r| r.name == r1.name}.first
      second = regs.select{|r| r.name == r2.name}.first
      expect(first.pass_name).to eq(pass.name)
      expect(second.pass_name).to eq(other_pass.name)
      expect(first.pass_price).to eq(pass.price)
      expect(first.signed_in).to eq(r1.signed_in)
    end

    it "should load registrants in alphabetical order" do
      r1 = Registrant.make pass: pass, name: 'Andrea', season: s
      r2 = Registrant.make pass: other_pass, name: 'Romina', season: s
      get :event, id: event.id

      regs = assigns(:registrants)
      expect(regs.length).to eq(2)
      expect(regs[0].name).to eq('Andrea')
      expect(regs[1].name).to eq('Romina')
    end
  end

end
