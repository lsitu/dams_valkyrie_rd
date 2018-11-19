# frozen_string_literal: true
FactoryBot.define do
  factory :object_resource do
    title "Title"
    to_create do |instance|
      Valkyrie.config.metadata_adapter.persister.save(resource: instance)
    end

    after(:build) do |resource, evaluator|
      resource
    end
  end
end
