require "rails_helper"
include ActionDispatch::TestProcess

RSpec.describe ObjectResourceController do
  let(:user) { nil }
  let(:collection) { FactoryBot.create_for_repository(:collection) }
  let(:agent1) { FactoryBot.create_for_repository(:agent) }
  let(:agent2) { FactoryBot.create_for_repository(:agent) }
  before do
    sign_in user if user
  end
  describe "new" do
    it "is successful" do
      get :new
      expect(response).to be_successful
    end
  end
  describe "create" do
    let(:params) do
      {
        title: ["Test Title"],
        creator_ids: [agent2.id],
        member_of_collection_ids: [collection.id]
      }
    end
    it "can create an object" do
      post :create, params: { object_resource: params }

      expect(response).to be_redirect
    end
  end
  describe "destroy" do
    it "can delete an object" do
      obj = FactoryBot.create_for_repository(:object_resource)
      delete :destroy, params: { id: obj.id.to_s }

      expect(response).to redirect_to object_resources_path
      expect { Valkyrie.config.metadata_adapter.query_service.find_by(id: obj.id) }.to raise_error ::Valkyrie::Persistence::ObjectNotFoundError
    end
  end
  describe "edit" do
    context "when object exist" do
      render_views
      it "renders a form" do
        obj = FactoryBot.create_for_repository(:object_resource)
        obj.member_of_collection_ids = [collection.id]
        obj.creator_ids = [agent2.id]
        get :edit, params: { id: obj.id.to_s }

        expect(response.body).to include obj.title.first
        expect(response.body).to include agent2.label.first
        expect(response.body).to include collection.title.first
        expect(response.body).to include 'Update Object resource'
      end
    end
  end
end
