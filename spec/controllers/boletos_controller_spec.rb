require 'rails_helper'
require 'webmock/rspec'

RSpec.describe BoletosController, type: :controller do
  render_views false

  let(:valid_attributes) {
    attributes_for(:boleto)
  }

  before do
    stub_request(:post, "https://api-sandbox.kobana.com.br/v1/bank_billets").
      to_return(status: 200, body: "", headers: {})
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new Boleto" do
        expect {
          post :create, params: { boleto: valid_attributes }
        }.to change(Boleto, :count).by(1)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Boleto" do
        expect {
          post :create, params: { boleto: valid_attributes.merge(amount: nil) }
        }.not_to change(Boleto, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested boleto" do
      boleto = Boleto.create! valid_attributes
      expect {
        delete :destroy, params: { id: boleto.to_param }
      }.to change(Boleto, :count).by(-1)
    end
  end
end