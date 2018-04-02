require 'rails_helper'

RSpec.describe Registrant, type: :model do

  def full_pass_csv
    File.open('spec/support/formulario.csv')
  end

  def couple_pass_csv
    File.open('spec/support/formulario_pareja.csv')
  end

  def unpaid_csv
    File.open('spec/support/unpaid_csv.csv')
  end

  def custom_field_names_csv
    File.open('spec/support/form_for_custom_upload_fields.csv')
  end

  let!(:s) { Season.make }
  let!(:pase_festival) { Pass.make name: "Pase festival" }
  let!(:pase_pareja) { Pass.make name: "Pase pareja" }

  describe "2016/2017 parser" do

    it "should parse a single user" do
      Registrant.parse(full_pass_csv)
      expect(Registrant.count).to eq(1)
    end

    it "should not create duplicates" do
      Registrant.parse(full_pass_csv)
      Registrant.parse(full_pass_csv)
      expect(Registrant.count).to eq(1)
    end

    it "should parse fields with accents in header" do
      Registrant.parse(full_pass_csv)
      expect(Registrant.first.email).to eq('mauro.giormenti@gmail.com')
    end

    # Deprecated
    # it "should add two users for couple" do
    #   Registrant.parse(couple_pass_csv)
    #   registrants = Registrant.all
    #   expect(registrants.count).to eq(2)
    #   expect(registrants[0].name).to eq('Pedro Gómez')
    #   expect(registrants[1].name).to eq('Juana Pérez')
    #   expect(registrants[0].pass).to eq(pase_pareja)
    #   expect(registrants[1].pass).to eq(pase_pareja)
    #   expect(registrants[1].email).to eq(nil)
    #   expect(registrants[0].role).to eq("leader")
    #   expect(registrants[1].role).to eq("follower")
    # end

    it "should register payment on new users" do
      Registrant.parse(full_pass_csv)
      expect(Registrant.first.paid).to eq(true)
    end

    it "should register payments on old users" do
      Registrant.parse(unpaid_csv)
      expect(Registrant.first.paid).to eq(false)
      Registrant.parse(full_pass_csv)
      expect(Registrant.first.paid).to eq(true)
    end

  end

  describe "custom fields parser" do

    before(:each) do
      s.upload_fields.build(code: "name", text: "Nombre y Apellido")
      s.upload_fields.build(code: "level", text: "¿En qué nivel querés participar?")
      s.upload_fields.build(code: "role", text: "¿Cuál es tu rol primario?")
      s.upload_fields.build(code: "email", text: "Correo electrónico")
      s.upload_fields.build(code: "partner", text: "¿Cual es el nombre de tu pareja?")
      s.upload_fields.build(code: "pass", text: "¿Qué pack te interesa?")
      s.upload_fields.build(code: "paid", text: "¿Pagó?")
      s.save
    end

    it "should parse 6 registrants" do
      Registrant.parse(custom_field_names_csv)
      expect(Registrant.count).to eq(6)
    end

    it "should parse correctly according to custom field 'role'" do
      Registrant.parse(custom_field_names_csv)
      expect(Registrant.first.role).to eq('follower')
    end

    it "should accept level as it comes from the form" do
      Registrant.parse(custom_field_names_csv)
      expect(Registrant.first.level).to eq("Open [Para todo los niveles - sin audición]")
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

  describe 'show current season' do
    it 'scope should return only passes for current' do
      s2 = Season.make current: false
      p1 = Registrant.make season: s
      p2 = Registrant.make season: s2

      expect(Registrant.current.to_a).to eq([p1])
    end

    it "should be the default" do
      s2 = Season.make current: false
      p1 = Registrant.make season: s
      p2 = Registrant.make season: s2

      expect(Registrant.all.to_a).to eq([p1])
    end
  end

end
