require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe PassesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Pass. As you add validations to Pass, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      name: 'Pase de fiestas',
      price: 300,
      description: 'WEEEE',
      colour: '#FFFFFF'
    }
  }

  let(:invalid_attributes) {
    { name: '' }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PassesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  let(:user) { User.make }
  before(:each) { sign_in user }

  describe "GET #index" do
    it "assigns all passes as @passes" do
      pass = Pass.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:passes)).to eq([pass])
    end
  end

  describe "GET #new" do
    it "assigns a new pass as @pass" do
      get :new, {}, valid_session
      expect(assigns(:pass)).to be_a_new(Pass)
    end
  end

  describe "GET #edit" do
    it "assigns the requested pass as @pass" do
      pass = Pass.create! valid_attributes
      get :edit, {:id => pass.to_param}, valid_session
      expect(assigns(:pass)).to eq(pass)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Pass" do
        expect {
          post :create, {:pass => valid_attributes}, valid_session
        }.to change(Pass, :count).by(1)
      end

      it "assigns a newly created pass as @pass" do
        post :create, {:pass => valid_attributes}, valid_session
        expect(assigns(:pass)).to be_a(Pass)
        expect(assigns(:pass)).to be_persisted
      end

      it "redirects to the created pass" do
        post :create, {:pass => valid_attributes}, valid_session
        expect(response).to redirect_to(passes_path)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved pass as @pass" do
        post :create, {:pass => invalid_attributes}, valid_session
        expect(assigns(:pass)).to be_a_new(Pass)
      end

      it "re-renders the 'new' template" do
        post :create, {:pass => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          name: 'Completo',
          price: 700,
          description: "todito",
          colour: '#000000'
        }
      }

      it "updates the requested pass" do
        pass = Pass.create! valid_attributes
        put :update, {:id => pass.to_param, :pass => new_attributes}, valid_session
        pass.reload
        expect(pass.name).to eq('Completo')
        expect(pass.colour).to eq('#000000')
      end

      it "assigns the requested pass as @pass" do
        pass = Pass.create! valid_attributes
        put :update, {:id => pass.to_param, :pass => valid_attributes}, valid_session
        expect(assigns(:pass)).to eq(pass)
      end

      it "redirects to the pass" do
        pass = Pass.create! valid_attributes
        put :update, {:id => pass.to_param, :pass => valid_attributes}, valid_session
        expect(response).to redirect_to(passes_path)
      end
    end

    context "with invalid params" do
      it "assigns the pass as @pass" do
        pass = Pass.create! valid_attributes
        put :update, {:id => pass.to_param, :pass => invalid_attributes}, valid_session
        expect(assigns(:pass)).to eq(pass)
      end

      it "re-renders the 'edit' template" do
        pass = Pass.create! valid_attributes
        put :update, {:id => pass.to_param, :pass => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested pass" do
      pass = Pass.create! valid_attributes
      expect {
        delete :destroy, {:id => pass.to_param}, valid_session
      }.to change(Pass, :count).by(-1)
    end

    it "redirects to the passes list" do
      pass = Pass.create! valid_attributes
      delete :destroy, {:id => pass.to_param}, valid_session
      expect(response).to redirect_to(passes_url)
    end
  end

end
