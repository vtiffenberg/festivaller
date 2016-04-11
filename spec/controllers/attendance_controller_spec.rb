require 'rails_helper'

RSpec.describe AttendanceController, type: :controller do

  describe "current event" do

    it "should select event correctly" do
      e = Event.make date: DateTime.now - 1.hour
      expect(@controller.instance_eval{ event_happening_now }).to eq(e)
    end

    it "should redirect to event if it is happening" do
      e = Event.make date: DateTime.now - 1.hour
      get :index

      expect(response).to redirect_to(attendance_path(e.id))
    end

    it "should show all events if it isn't" do
      e = Event.make date: DateTime.now + 2.hours
      get :index

      expect(response.status).to eq(200)
      expect(assigns(:events)).to eq([e])
    end

  end

end
