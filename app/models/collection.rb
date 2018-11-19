# frozen_string_literal: true
class Collection < Valkyrie::Resource
  include Valkyrie::Resource::AccessControls
  attribute :title, Valkyrie::Types::Set
  attribute :description, Valkyrie::Types::Set
  attribute :date_created, Valkyrie::Types::Set
  attribute :publisher_ids, Valkyrie::Types::Set
  attribute :member_collection_ids, Valkyrie::Types::Array

  def primary_terms
    [:title, :description, :date_created, :publisher_ids, :member_collection_ids]
  end
end