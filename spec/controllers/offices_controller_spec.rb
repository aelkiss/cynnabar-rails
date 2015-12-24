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

RSpec.describe OfficesController, type: :controller do
  before(:each) { sign_in(create(:user, :admin)) }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # OfficesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all offices as @offices" do
      office = create(:office)
      get :index, {}, valid_session
      expect(assigns(:offices)).to eq([office])
    end
  end

  describe "GET #show" do
    it "assigns the requested office as @office" do
      office = create(:office)
      get :show, {:id => office.to_param}, valid_session
      expect(assigns(:office)).to eq(office)
    end
  end

  describe "GET #new" do
    it "assigns a new office as @office" do
      get :new, {}, valid_session
      expect(assigns(:office)).to be_a_new(Office)
    end
  end

  describe "GET #edit" do
    it "assigns the requested office as @office" do
      office = create(:office)
      get :edit, {:id => office.to_param}, valid_session
      expect(assigns(:office)).to eq(office)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Office" do
        expect {
          post :create, {:office => attributes_for(:office)}, valid_session
        }.to change(Office, :count).by(1)
      end

      it "assigns a newly created office as @office" do
        post :create, {:office => attributes_for(:office)}, valid_session
        expect(assigns(:office)).to be_a(Office)
        expect(assigns(:office)).to be_persisted
      end

      it "redirects to the created office" do
        post :create, {:office => attributes_for(:office)}, valid_session
        expect(response).to redirect_to(Office.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved office as @office" do
        post :create, {:office => attributes_for(:office, name: nil)}, valid_session
        expect(assigns(:office)).to be_a_new(Office)
      end

      it "re-renders the 'new' template" do
        post :create, {:office => attributes_for(:office, name: nil)}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested office" do
        office = create(:office)
        updates = attributes_for(:office)
        put :update, {:id => office.to_param, :office => updates}, valid_session
        office.reload

        expect(office.name).to eq(updates[:name])
        expect(office.email).to eq(updates[:email])
        expect(office.image).to eq(updates[:image])
      end

      it "assigns the requested office as @office" do
        office = create(:office)
        put :update, {:id => office.to_param, :office => attributes_for(:office)}, valid_session
        expect(assigns(:office)).to eq(office)
      end

      it "redirects to the office" do
        office = create(:office)
        put :update, {:id => office.to_param, :office => attributes_for(:office)}, valid_session
        expect(response).to redirect_to(office)
      end
    end

    context "with invalid params" do
      it "assigns the office as @office" do
        office = create(:office)
        put :update, {:id => office.to_param, :office => attributes_for(:office, name: nil)}, valid_session
        expect(assigns(:office)).to eq(office)
      end

      it "re-renders the 'edit' template" do
        office = create(:office)
        put :update, {:id => office.to_param, :office => attributes_for(:office, name: nil)}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested office" do
      office = create(:office)
      expect {
        delete :destroy, {:id => office.to_param}, valid_session
      }.to change(Office, :count).by(-1)
    end

    it "redirects to the offices list" do
      office = create(:office)
      delete :destroy, {:id => office.to_param}, valid_session
      expect(response).to redirect_to(offices_url)
    end
  end

end
