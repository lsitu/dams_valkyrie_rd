# frozen_string_literal: true
require "rails_helper"

RSpec.describe ObjectResource do
  let(:creator_id) { Agent.new({id: SecureRandom.uuid, label: "Creator"}).id }
  let(:member_id) { described_class.new({id: SecureRandom.uuid, title: "Child component title"}).id }
  let(:member_of_collection_id) { Collection.new({id: SecureRandom.uuid, title: "Test Collection"}).id }
  let(:obj) { described_class.new({ id: SecureRandom.uuid,
                                    title: "Test object title",
                                    creator_ids: [creator_id],
                                    member_of_collection_ids: [member_of_collection_id],
                                    member_ids: [member_id] }) }

  it "has title" do
    expect(obj.title).to eq ['Test object title']
  end

  it "has creator_ids" do
    expect(obj.creator_ids.first).to eq creator_id
  end

  it "has ordered member_ids" do
    expect(obj.member_ids.first).to eq member_id
  end

  it "has member_of_collection_ids" do
    expect(obj.member_of_collection_ids.first).to eq member_of_collection_id
  end
end
