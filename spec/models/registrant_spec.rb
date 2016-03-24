require 'rails_helper'

RSpec.describe Registrant, type: :model do

  def model_csv
    File.open('spec/support/formulario.csv')
  end

  before(:each) do
    Pass.make name: "Pase festival"
  end

  describe "parser" do

    it "should parse a single user" do
      Registrant.parse(model_csv)
      expect(Registrant.count).to eq(1)
    end

    it "should not create duplicates" do
      Registrant.parse(model_csv)
      Registrant.parse(model_csv)
      expect(Registrant.count).to eq(1)
    end

    it "should parse fields with accents in header" do
      Registrant.parse(model_csv)
      expect(Registrant.first.email).to eq('mauro.giormenti@gmail.com')
    end

  end

  describe "validations" do

    it "should not allow free text in role" do
      r = Registrant.make_unsaved role: 'loser', pass: Pass.first
      expect(r).to be_invalid
    end

    it "should allow valid values in role" do
      r = Registrant.make_unsaved role: 'leader', pass: Pass.first
      expect(r).to be_valid
    end
  end

end
