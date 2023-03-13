require 'rails_helper'

RSpec.describe Api::V1::Topics::TopicsController, type: :controller do
  describe "GET #show" do
    let!(:user1) { create(:user, name: "John Doe", email: "testmail@gmail,com", uid: "iamTestUser") }
    let(:appoint) { create(:appoint, title: "testTitle", content: "testContent", user_id: user1.uid, end: DateTime.now + 1.hour) }
    let(:character) { create(:character) }
    before do
      allow(controller).to receive(:authenticate_user).and_return(true)
      allow(controller).to receive(:current_user).and_return(user1)
    end

    it "create new topic" do
      expect do
        post :create, params: { topic: { appoint_id: appoint.id, character_id: character.id } }
      end.to change(Topic, :count).by(1)
    end
    it "destroy topic" do
      # 投稿を作成
      post :create, params: { topic: { appoint_id: appoint.id, character_id: character.id } }
      # topicのidをレスポンスのjsonから取得
      topic_id = JSON.parse(response.body)["id"]
      expect do
        delete :destroy, params: { id: topic_id }
      end.to change(Topic, :count).by(-1)
    end
  end
end
