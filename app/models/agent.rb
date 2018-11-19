# frozen_string_literal: true
class Agent < Valkyrie::Resource
  attribute :label, Valkyrie::Types::Set
  attribute :alternateLabel, Valkyrie::Types::Set
  attribute :orcid, Valkyrie::Types::Set
  attribute :identifier, Valkyrie::Types::Set
  attribute :type, Valkyrie::Types::Set

  def primary_terms
    [:label, :alternateLabel, :orcid, :identifier, :type]
  end
end