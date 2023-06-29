# frozen_string_literal: true

module HighSchools::LocationConcern
  extend ActiveSupport::Concern

  included do
    # Callback
    before_create :set_province_id_and_district_id

    def address
      return nil if commune_id.blank?

      Pumi::Commune.find_by_id(commune_id).try(:address_km)
    end

    def commune
      return nil if commune_id.blank?

      Pumi::Commune.find_by_id(commune_id).try(:name_km)
    end

    def district
      return nil if district_id.blank?

      Pumi::District.find_by_id(district_id).try(:name_km)
    end

    def province
      return nil if province_id.blank?

      Pumi::Province.find_by_id(province_id).try(:name_km)
    end

    private
      def set_province_id_and_district_id
        self.district_id ||= commune_id[0..3]
        self.province_id ||= district_id[0..1]
      end
  end
end
