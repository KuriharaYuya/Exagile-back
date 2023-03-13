require 'rails_helper'

RSpec.describe Api::V1::AppointCharacters::AppointCharactersController, type: :controller do
  describe "GET #show" do
    let!(:user1) { create(:user, name: "John Doe", email: "testmail@gmail,com", uid: "iamTestUser") }
    let(:appoint) { create(:appoint, title: "testTitle", content: "testContent", user_id: user1.uid, end: DateTime.now + 1.hour) }
    let(:character) { create(:character) }
    before do
      allow(controller).to receive(:authenticate_user).and_return(true)
      allow(controller).to receive(:current_user).and_return(user1)
    end

    it "create new appointCharacter" do
      expect do
        post :create, params: { appoint_id: appoint.id, character_id: character.id }
      end.to change(AppointCharacter, :count).by(1)
    end

    it "destroy appointCharacter" do
      post :create, params: { appoint_id: appoint.id, character_id: character.id }
      expect do
        delete :destroy, params: { appoint_id: appoint.id, character_id: character.id  }
      end.to change(AppointCharacter, :count).by(-1)
    end
  end
end
