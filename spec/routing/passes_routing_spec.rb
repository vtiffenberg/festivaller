require "rails_helper"

RSpec.describe PassesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/passes").to route_to("passes#index")
    end

    it "routes to #new" do
      expect(:get => "/passes/new").to route_to("passes#new")
    end

    it "routes to #edit" do
      expect(:get => "/passes/1/edit").to route_to("passes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/passes").to route_to("passes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/passes/1").to route_to("passes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/passes/1").to route_to("passes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/passes/1").to route_to("passes#destroy", :id => "1")
    end

  end
end
