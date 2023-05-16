# frozen_string_literal: true

require "csv"
require "zip_file_generator"

class AssessmentResultService
  def initialize(users)
    @users = users
    @folder = "#{Rails.root}/tmp/assessment_result"
    @user_info_columns = [
      { code: "id", name: "លេខរៀង" },
      { code: "username", name: "ឈ្មោះគណនី" },
      { code: "full_name", name: "ឈ្មោះពេញ" },
      { code: "sex", name: "ភេទ" },
      { code: "date_of_birth", name: "ថ្ងៃខែឆ្នាំកំណើត" },
      { code: "phone_number", name: "លេខទូរស័ព្ទ" },
      { code: "grade", name: "ថ្នាក់ទី" },
      { code: "high_school_label", name: "រៀននៅសាលា" }
    ]

    @personal_understanding_columns = [
      { code: "are_you_going_to_study_till_grade12", name: "តើអ្នកនឹងបន្តការសិក្សារហូតដល់ថ្នាក់ទី១២ដែរឬទេ?" },
      { code: "are_your_parents_allow_you_to_study_till_grade12", name: "តើឪពុកម្តាយរបស់ប្អូននឹងអនុញ្ញាតឲ្យប្អូនបន្តការសិក្សរហូតដល់ថ្នាក់ទី១២ដែរឬទេ?" },
      { code: "have_you_ever_thought_of_career", name: "តើប្អូនធ្លាប់គិតពីការងារមួយណាដែលប្អូនចង់ធ្វើក្រោយពេលបញ្ចប់ការសិក្សាដែរឬទេ?" },
      { code: "career_name", name: "តើការងារនោះជាការងារអ្វី" },
      { code: "how_to_reach_career_goal", name: "តើប្អូនអាចស្វែងរកការងារបានដោយវិធីណាខ្លះ?" },
      { code: "does_parents_agree_with", name: "តើឪពុកម្តាយប្អូនយល់ស្របជាមួយគំនិតរបស់ប្អូនដែរឬទេ?" },
      { code: "ever_talked_with_anyone_about_career", name: "តើអ្នកធ្លាប់និយាយជាមួយនរណាម្នាក់ពីការងារអនាគត់របស់អ្នកដែរឬទេ?" },
      { code: "how_to_reach_job_vacancy", name: "តើអ្នកអាចស្វែងរកការងារឬស្រាវជ្រាវរកមុខរបរតាមរយះអ្វីខ្លះ?" }
    ]

    @subject_columns = [
      { code: "khmer_reading", name: "ការអានភាសាខ្មែរ" },
      { code: "khmer_writing", name: "ការសរសេរភាសាខ្មែរ" },
      { code: "english", name: "ភាសាបរទេស" },
      { code: "social_study_ethics_and_citizenship", name: "សីលធម៌និងពលរដ្ឋ" },
      { code: "social_study_geography", name: "ភូមិវិទ្យា" },
      { code: "social_study_history", name: "ប្រវត្តិវិទ្យា" },
      { code: "math", name: "គណិតវិទ្យា" },
      { code: "science_physics", name: "រូបវិទ្យា" },
      { code: "science_chemistry", name: "គីមីវិទ្យា" },
      { code: "science_biology", name: "ជីវៈវិទ្យា" },
      { code: "soft_skill_communication", name: "ទំនាក់ទំង" },
      { code: "soft_skill_problem_solving", name: "ដោះស្រាយបញ្ហា" },
      { code: "soft_skill_brave", name: "ក្លាហាន" },
      { code: "soft_skill_public_speaking", name: "ការនិយាយសាធារណៈ" },
      { code: "soft_skill_teamwork", name: "ការងារក្រុម" }
    ]

    @other_columns = [
      { code: "characteristics", name: "ការបំពេញបុគ្គលិកលក្ខណៈ" },
      { code: "careers", name: "ការជ្រើសរើសមុខរបរផ្អែកលើបុគ្គលិលក្ខណៈ" },
      { code: "goal_career", name: "មុខរបរដែលអ្នកប្រើប្រាស់ជ្រើសយក" },
      { code: "reason", name: "ដាក់គោលដៅនិងមូលហេតុជាអក្សរ" },
      { code: "audio", name: "ដាក់គោលដៅនិងមូលហេតុជាសម្លេង" },
      { code: "created_at", name: "ថ្ងៃធ្វើតេស្ត" }
    ]

    @personality_assessment_colums = [
      { code: "realistic", name: "ប្រាកដនិយម" },
      { code: "investigative", name: "ពូកែអង្កេត" },
      { code: "artistic", name: "សិល្បៈនិយម" },
      { code: "social", name: "សង្គម" },
      { code: "enterprising", name: "ត្រិះរិះពិចារណា" },
      { code: "conventional", name: "សណ្ដាប់ធ្នាប់" }
    ]
  end

  def zip_data
    write_file_career_assessment
    write_file_personality_assessment

    directory_to_zip = "#{Rails.root}/tmp/assessment_result"
    output_file = "#{Rails.root}/tmp/assessment_result.zip"
    zf = ZipFileGenerator.new(directory_to_zip, output_file)
    zf.write

    File.read(output_file)
  end

  private
    def write_file_career_assessment
      FileUtils.mkdir_p(@folder) unless File.directory?(@folder)

      CSV.open("#{@folder}/career_assessment.csv", "wb") do |csv|
        csv << build_columns

        @users.each do |user|
          user.games.each do |game|
            csv << build_csv_record(user, game)
          end
        end
      end
    end

    def write_file_personality_assessment
      FileUtils.mkdir_p(@folder) unless File.directory?(@folder)

      CSV.open("#{@folder}/personality_assessment.csv", "wb") do |csv|
        csv << build_personality_test_columns

        @users.each do |user|
          user.personality_tests.each do |test|
            csv << build_personality_test_csv_record(user, test)
          end
        end
      end
    end

    def build_personality_test_columns
      columns = @user_info_columns.dup
      columns = columns.concat(@personality_assessment_colums)
      columns = columns.pluck(:name)
      columns = columns.push("ថ្ងៃធ្វើតេស្ត")
      columns
    end

    def build_personality_test_csv_record(user, test)
      data = build_user_info(user)

      @personality_assessment_colums.each do |column|
        arr = test.personalities.select { |personality| personality.category == column[:code] }
        data.push(arr.pluck(:name_km).join(";"))
      end

      data.push(test.created_at)
      data
    end

    def build_csv_record(user, game)
      data = build_user_info(user)
      data = data.concat(build_personal_understanding(game))
      data = data.concat(build_subject(game))
      data = data.concat(build_other(game))
      data
    end

    def build_user_info(user)
      desired_columns = @user_info_columns.pluck(:code)
      desired_columns = desired_columns.delete_if { |x| x == "high_school_label" }
      arr = user.attributes.values_at(*desired_columns)
      arr.push user.high_school_label
      arr
    end

    def build_personal_understanding(game)
      desired_columns = @personal_understanding_columns.pluck(:code)
      game.personal_understandings.last.attributes.values_at(*desired_columns)
    end

    def build_subject(game)
      desired_columns = @subject_columns.pluck(:code)
      game.subject.attributes.values_at(*desired_columns)
    end

    def build_other(game)
      characteristics = game.entries.pluck(:name).join(";")
      careers = game.careers.pluck(:name).join(";")
      goal_career = game.goal_career.try(:name)
      reason = game.reason
      audio = game.audio.url
      created_at = game.created_at

      [characteristics, careers, goal_career, reason, audio, created_at]
    end

    def build_columns
      columns = @user_info_columns.dup
      columns = columns.concat(@personal_understanding_columns)
      columns = columns.concat(@subject_columns)
      columns = columns.concat(@other_columns)
      columns = columns.pluck(:name)
      columns
    end
end
