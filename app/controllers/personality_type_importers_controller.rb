# frozen_string_literal: true

class PersonalityTypeImportersController < ApplicationController
  include Batches::ItemableImportersConcern

  private
    def batch_type
      "PersonalityTypeBatch"
    end

    def redirect_success_url
      personality_types_url
    end

    def redirect_error_url
      new_personality_type_importer_url
    end

    def itemable_attributes
      [
        :id, :code, :name_km, :name_en, :description,
        :personal_value, :skill_and_ability, :recommendation
      ]
    end
end
