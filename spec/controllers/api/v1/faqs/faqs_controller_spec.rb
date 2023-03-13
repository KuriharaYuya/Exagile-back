require 'rails_helper'

RSpec.describe Api::V1::Faqs::FaqsController, type: :controller do
  describe "GET #show" do
    let!(:user1) { create(:user, name: "John Doe", email: "testmail@gmail,com", uid: "iamTestUser") }
    let(:appoint) { create(:appoint, title: "testTitle", content: "testContent", user_id: user1.uid, end: DateTime.now + 1.hour) }
    before do
      allow(controller).to receive(:authenticate_user).and_return(true)
      allow(controller).to receive(:current_user).and_return(user1)
    end

    it "create new faq" do
      expect do
        post :create, params: { faq: { appoint_id: appoint.id, name: "testFaqName", content: "testContent", faq_type: "inspired_appoint" } }
      end.to change(Faq, :count).by(1)
    end
    it "destroy faq" do
      post :create, params: { faq: { appoint_id: appoint.id, name: "testFaqName", content: "testContent", faq_type: "inspired_appoint" } }
      # レスポンスからfaqのidを取得
      faq_id = JSON.parse(response.body)["id"]
      expect do
        delete :destroy, params: { id: faq_id }
      end.to change(Faq, :count).by(-1)
    end
  end
end
