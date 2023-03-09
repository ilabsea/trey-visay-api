# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  is_admin               :boolean          default(FALSE)
#  is_counsellor          :boolean          default(FALSE)
#  schools                :text(65535)
#  authentication_token   :string(255)
#  token_expired_date     :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  role                   :integer
#  deleted_at             :datetime
#  locale                 :string(255)
#  counselor_school_id    :string(255)
#
# Indexes
#
#  index_accounts_on_email                 (email) UNIQUE
#  index_accounts_on_reset_password_token  (reset_password_token) UNIQUE
#

class Account < ApplicationRecord
  acts_as_paranoid

  include Accounts::Confirmable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  serialize :schools, Array

  # Enum
  enum role: {
    primary_admin: 1,
    admin: 2,
    counselor: 3
  }

  # Callback
  before_create :reset_authentication_token
  before_save :ensure_authentication_token
  before_create :ensure_authentication_token

  # Validation
  validates :email, presence: true
  validates :role, presence: true
  validates :counselor_school_id, presence: true, if: -> { counselor? }

  # Constant
  ROLES = [["អ្នកគ្រប់គ្រង", "admin"], ["អ្នកប្រឹក្សាយោបល់", "counselor"]]

  # Association
  belongs_to :counselor_school, optional: true

  # Delegation
  delegate :name, to: :counselor_school, prefix: true, allow_nil: true

  # Scope
  default_scope { order(updated_at: :desc) }

  # Instant method
  def status
    return "archived" if deleted?
    return "actived" if confirmed?

    "pending"
  end

  def display_name
    email.split("@").first.upcase
  end

  # Class methods
  def self.filter(params = {})
    scope = all
    scope = scope.where("email LIKE ?", "%#{params[:email]}%") if params[:email].present?
    scope = scope.only_deleted if params[:archived] == "true"
    scope
  end

  private
    def reset_authentication_token
      self.authentication_token = nil
      self.token_expired_date = Time.now
    end

    def ensure_authentication_token
      self.authentication_token = Devise.friendly_token
      self.token_expired_date = Time.now + 2.week
    end

    def refresh_authentication_token
      ensure_authentication_token
      save!
    end
end
