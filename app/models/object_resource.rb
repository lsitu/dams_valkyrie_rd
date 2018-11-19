# frozen_string_literal: true
class ObjectResource < Valkyrie::Resource
  include Valkyrie::Resource::AccessControls
  attribute :title, Valkyrie::Types::Set
  attribute :date_created, Valkyrie::Types::Set
  attribute :creator_ids, Valkyrie::Types::Set
  attribute :member_of_collection_ids, Valkyrie::Types::Set
  attribute :member_ids, Valkyrie::Types::Array

  def primary_terms
    [:title, :date_created, :creator_ids, :member_of_collection_ids, :member_ids]
  end
end