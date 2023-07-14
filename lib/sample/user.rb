# frozen_string_literal: true

require_relative "base"

module Sample
  class User < Sample::Base
    def simulate(count = 1)
      count.times.each do |i|
        user = create_user
        ::Sample::HollandQuiz.new(user).simulate if [true, false].sample
        ::Sample::IntelligenceQuiz.new(user).simulate if [true, false].sample
      end
    end

    def create_user
      user = ::User.new(
        uuid: SecureRandom.uuid,
        full_name: FFaker::Name.name,
        sex: %w(ប្រុស ស្រី).sample,
        date_of_birth: Date.new(rand(1990..2015)),
        phone_number: FFaker::PhoneNumber.short_phone_number,
        grade: ::User::GRADES.sample
      )
      user.update(
        class_group: %w(11 12).include?(user.grade) ? ::User.class_groups.keys.sample : nil,
        high_school_code: user.grade_other? ? nil : ::HighSchool.all.sample.code,
        registered_at: rand(1..90).days.ago,
        other_grade: user.grade_other? ? ::User.other_grades.keys.sample : nil,
        device_id: SecureRandom.uuid[0..7],
        device_type: ::User.device_types.keys.sample,
        device_os: ::User.device_os.keys.sample,
        app_version: "1.0.0"
      )

      user
    end
  end
end
