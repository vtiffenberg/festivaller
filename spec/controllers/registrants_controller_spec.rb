require 'rails_helper'

RSpec.describe RegistrantsController, type: :controller do

  let!(:s) { Season.make }
  let(:user) { User.make }
  before(:each) { sign_in user }

  describe "request" do

    it "loads the index" do
      get :index
      expect(response).to be_success
    end

    it "loads edit" do
      r = Registrant.make
      get :edit, id: r.id
      expect(response).to be_success
    end

    it "loads upload" do
      get :upload
      expect(response).to be_success
    end

  end

  describe "quick actions" do

    let!(:registrant) { Registrant.make paid: false, signed_in: false }
    let!(:event) { Event.make }

    it "should take payment" do
      post :pay, id: registrant.id, event_id: event.id
      expect(response).to be_success
      expect(registrant.reload.paid).to be true
    end

    it "should notify payment is from event" do
      post :pay, id: registrant.id, event_id: event.id
      expect(registrant.reload.paid_at_event).to eq(event.id)
    end

    it "should mark as signed in" do
      post :sign_in, id: registrant.id
      expect(response).to be_success
      expect(registrant.reload.signed_in).to be true
    end

  end

  it "should update registrants info" do
    r = Registrant.make
    post :update, id: r.id, registrant: { name: "New name", paid: true }
    expect(r.reload.paid).to be true
    expect(r.name).to eq "New name"
  end

end
