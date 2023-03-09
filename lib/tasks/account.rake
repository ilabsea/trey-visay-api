# frozen_string_literal: true

namespace :account do
  desc 'Migrate role and confirm'
  task migrate_role_and_confirm: :environment do
    Account.all.each do |account|
      account.update(role: get_role(account), counselor_school_id: get_counselor_school_id(account))
      account.confirm
    end
  end

  private
    def get_role(account)
      account.is_admin? ? 'admin' : 'counselor'
    end

    def get_counselor_school_id(account)
      return nil unless account.is_counsellor?

      CounselorSchool.find_by(name: account.schools[0]).try(:id)
    end
end
