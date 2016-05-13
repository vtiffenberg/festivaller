require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  let(:user) { User.make }
  before(:each) { sign_in user }

  describe "setting" do

    it "loads index" do
      get :settings
      expect(response).to be_success
    end

  end

end
