# frozen_string_literal: true

module BatchConcern
  extend ActiveSupport::Concern

  included do
    # Association
    belongs_to :creator, class_name: "Account"

    # Uploader
    mount_uploader :reference, AttachmentUploader

    # Callback
    before_create :secure_id
    before_create :secure_code

    # Delegation
    delegate :email, to: :creator, prefix: :creator, allow_nil: true

    # Instant method
    def edit_count
      total_count - new_count
    end

    def invalid_count
      total_count - valid_count
    end

    # Class method
    def self.filter(params)
      keyword = params[:keyword].to_s.strip
      scope = all
      scope = scope.where("code LIKE ? OR filename LIKE ?", "%#{keyword}%", "%#{keyword}%") if keyword.present?
      scope
    end
  end
end
