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
#  actived                :boolean          default(TRUE)
#  gf_user_id             :integer
#  province_id            :string(255)
#  district_id            :string(255)
#  full_name              :string(255)
#  phone_number           :string(255)
#
# Indexes
#
#  index_accounts_on_email                 (email) UNIQUE
#  index_accounts_on_reset_password_token  (reset_password_token) UNIQUE
#

class Account < ApplicationRecord
  acts_as_paranoid

  include Accounts::Confirmable
  include Accounts::GrafanaConcern
  include Accounts::OauthProvider

  attr_accessor :skip_callback

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  serialize :schools, Array

  # Enum
  enum role: {
    primary_admin: 1,
    admin: 2,
    counselor: 3,
    trainer: 4
  }

  # Callback
  before_create :reset_authentication_token
  before_save :ensure_authentication_token
  before_create :ensure_authentication_token
  after_commit :clean_unused_account_high_school, if: -> { saved_change_to_attribute("role") && counselor? }

  # Validation
  validates :email, presence: true
  validates :role, presence: true
  validates :high_school_ids, presence: true, if: :counselor?
  validates :province_ids, presence: true, if: :trainer?

  # Constant
  ROLES = [
    ["អ្នកគ្រប់គ្រងប្រព័ន្ធ", "primary_admin"],
    ["អ្នកគ្រប់គ្រង", "admin"],
    ["គ្រូប្រឹក្សាតាមសាលារៀន", "counselor"],
    ["គ្រូឧទ្ទេសថ្នាក់ជាតិ", "trainer"]
  ]

  # Association
  has_many :account_high_schools
  has_many :high_schools, through: :account_high_schools
  has_many :provinces, through: :account_high_schools

  # Scope
  default_scope { order(created_at: :desc) }

  # Instant method
  def status
    return "archived" if deleted?
    return "actived" if confirmed? && actived?
    return "deactivated" unless actived?

    "pending"
  end

  def display_name
    email.split("@").first.upcase
  end

  def in_school_other?
    high_school_ids.include? "other"
  end

  # Class methods
  def self.filter(params = {})
    scope = all
    scope = scope.where("email LIKE ?", "%#{params[:email]}%") if params[:email].present?
    scope = scope.where(role: params[:role]) if params[:role].present?
    scope = scope.joins(:account_high_schools).where("account_high_schools.province_id = ?", params[:province_id]) if params[:province_id].present?
    scope = scope.joins(:account_high_schools).where("account_high_schools.district_id = ? OR account_high_schools.district_id = 'all'", params[:district_id]) if params[:district_id].present?
    scope = scope.joins(:account_high_schools).where("account_high_schools.high_school_id = ? OR account_high_schools.high_school_id = 'all'", params[:high_school_code]) if params[:high_school_code].present?
    scope = scope.only_deleted if params[:archived] == "true"
    scope
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = Account.where(email: data["email"]).first
    user
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

    def clean_unused_account_high_school
      schools = account_high_schools.where(high_school_id: "all")
      schools.delete_all
    end
end
