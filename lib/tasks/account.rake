# frozen_string_literal: true

namespace :account do
  desc "Migrate role and confirm"
  task migrate_role_and_high_school: :environment do
    Account.where(role: nil).each do |account|
      school = get_high_school(account)
      account.skip_confirmation!
      account.update(
        role: get_role(account),
        high_school_ids: [school.try(:id)],
        province_id: school.try(:province_id),
        district_id: school.try(:district_id)
      )
    end
  end

  desc "Migrate role and confirm"
  task migrate_high_school: :environment do
    AccountHighSchool.all.each do |ah|
      ah.update_columns(province_id: ah.high_school.province_id, district_id: ah.high_school.district_id)
    end
  end

  private
    def get_role(account)
      account.is_admin? ? "admin" : "counselor"
    end

    def get_high_school(account)
      return nil unless account.is_counsellor?
      school_name = get_school_name[account.schools[0].to_sym] || account.schools[0]

      HighSchool.find_by(name_km: school_name)
    end

    def get_school_name
      {
        "វិទ្យាល័យហ.សពាមជីកង": "វិទ្យាល័យហ៊ុនសែនពាមជីកង",
        "សាលាជំនាន់ថ្មីវិទ្យាល័យព្រះស៊ីសុវត្ថិ": "វិទ្យាល័យព្រះស៊ីសុវត្ថិ",
        "វិទ្យាល័យជាស៊ីមព្រែកអញ្ចាញ": "វិទ្យាល័យព្រែកអញ្ជាញ"
      }
    end
end
