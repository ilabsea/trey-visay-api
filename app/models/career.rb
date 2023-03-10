# frozen_string_literal: true

# == Schema Information
#
# Table name: careers
#
#  id                  :bigint(8)        not null, primary key
#  name                :string(255)      not null
#  description         :text(65535)
#  places_for_work     :string(255)
#  categorizable_type  :string(255)
#  categorizable_id    :bigint(8)
#  unknown_schools     :text(65535)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  code                :string(255)
#  short_description   :text(65535)
#  duty                :text(65535)
#  working_environment :text(65535)
#  training_level      :string(255)
#  salary              :string(255)
#
# Indexes
#
#  index_careers_on_categorizable_type_and_categorizable_id  (categorizable_type,categorizable_id)
#  index_careers_on_code                                     (code) UNIQUE
#

class Career < ApplicationRecord
  belongs_to :categorizable, polymorphic: true
  has_and_belongs_to_many :schools
  has_many :career_games, foreign_key: :career_code, primary_key: :code
  has_many :games, through: :career_games

  has_many :personality_category_careers, foreign_key: :career_code, primary_key: :code, dependent: :destroy
  has_many :personality_categories, through: :personality_category_careers

  validates :name, presence: true
  validates :code, uniqueness: true, if: -> { code.present? }

  def self.append_field_with_csv(filename, append_field = 'code', search_field = 'name')
    raise 'Missing filename' unless filename.present?

    path = FileUtil.path_of(filename)

    raise "File #{path} not found" unless File.exist? path

    csv = CSV.parse(File.read(path), headers: true)

    csv.each do |csv_row|
      row = csv_row.to_hash

      next if row[search_field].nil?

      career = Career.find_by(name: row[search_field].strip)

      next if career.nil?

      career.update_attributes!(append_field => row[append_field].strip)
    end
  end
end
