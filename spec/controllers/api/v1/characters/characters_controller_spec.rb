require 'rails_helper'

RSpec.describe Api::V1::Characters::CharactersController, type: :controller do
  describe "POST #create" do
    let!(:user1) { create(:user, name: "John Doe", email: "testmail@gmail,com", uid: "iamTestUser") }
    let(:appoint) { create(:appoint, title: "testTitle", content: "testContent", user_id: user1.id, end: DateTime.now + 1.hour) }
    let(:character_params) { { appoint_id: appoint.id, keyword: "Test Character" } }

    before do
      allow(controller).to receive(:authenticate_user).and_return(true)
      allow(controller).to receive(:current_user).and_return(user1)
    end

    it "creates a new character" do
      expect do
        post :create, params: { character: character_params }
      end.to change(Character, :count).by(1)

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include("character")
      expect(Character.last.name).to eq("Test Character")
      # bundle exec rspec
    end
  end
end
