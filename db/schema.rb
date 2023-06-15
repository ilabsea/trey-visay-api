# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_06_14_043021) do

  create_table "accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_admin", default: false
    t.boolean "is_counsellor", default: false
    t.text "schools"
    t.string "authentication_token"
    t.datetime "token_expired_date"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "role"
    t.datetime "deleted_at"
    t.string "locale"
    t.string "counselor_school_id"
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  end

  create_table "api_keys", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "access_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "batches", id: :string, limit: 8, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.integer "total_count", default: 0
    t.integer "valid_count", default: 0
    t.integer "new_count", default: 0
    t.integer "province_count", default: 0
    t.string "reference"
    t.integer "creator_id"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "careers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "places_for_work"
    t.string "categorizable_type"
    t.bigint "categorizable_id"
    t.text "unknown_schools"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.text "short_description"
    t.text "duty"
    t.text "working_environment"
    t.string "training_level"
    t.string "salary"
    t.index ["categorizable_type", "categorizable_id"], name: "index_careers_on_categorizable_type_and_categorizable_id"
    t.index ["code"], name: "index_careers_on_code", unique: true
  end

  create_table "careers_games", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "career_id"
    t.bigint "game_id"
    t.boolean "is_goal", default: false
    t.string "career_code"
    t.index ["career_code"], name: "index_careers_games_on_career_code"
    t.index ["career_id"], name: "index_careers_games_on_career_id"
    t.index ["game_id"], name: "index_careers_games_on_game_id"
  end

  create_table "careers_schools", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "career_id"
    t.bigint "school_id"
    t.index ["career_id"], name: "index_careers_schools_on_career_id"
    t.index ["school_id"], name: "index_careers_schools_on_school_id"
  end

  create_table "characteristics", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "concern_subjects"
  end

  create_table "characteristics_entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "characteristic_id"
    t.bigint "entry_id"
    t.boolean "concerned", default: false
    t.index ["characteristic_id"], name: "index_characteristics_entries_on_characteristic_id"
    t.index ["entry_id"], name: "index_characteristics_entries_on_entry_id"
  end

  create_table "college_majors", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "personality_type"
    t.text "general_info"
    t.text "orien_orientation_subjects"
    t.text "orien_study_condition"
    t.text "orien_graduation_condition"
    t.text "curriculum"
    t.text "teaching_and_learning_process"
    t.text "gain_knowledge"
    t.text "worthy_career"
    t.text "recommendation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "counselor_schools", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "entries_games", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "entry_id"
    t.bigint "game_id"
    t.index ["entry_id"], name: "index_entries_games_on_entry_id"
    t.index ["game_id"], name: "index_entries_games_on_game_id"
  end

  create_table "games", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "characteristic_id"
    t.string "reason"
    t.string "audio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "created_date"
    t.string "goal"
  end

  create_table "high_schools", primary_key: "code", id: :string, limit: 7, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name_km"
    t.string "name_en"
    t.string "location_code"
    t.index ["code"], name: "index_high_schools_on_code", unique: true
  end

  create_table "holland_job_responses", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "holland_quiz_id"
    t.string "job_id"
    t.boolean "selected"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "holland_major_responses", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "holland_quiz_id"
    t.string "college_major_id"
    t.boolean "selected"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "holland_questions", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "personality_type"
    t.integer "display_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "holland_quizzes", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.string "personality_type_results"
    t.string "college_major_id"
    t.string "job_id"
    t.datetime "quizzed_at"
    t.datetime "selected_college_major_at"
    t.datetime "selected_job_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "holland_responses", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "holland_quiz_id"
    t.string "holland_question_id"
    t.string "holland_question_code"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "holland_scores", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "holland_quiz_id"
    t.string "personality_type"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "importing_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "itemable_id"
    t.string "itemable_type"
    t.string "batch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.string "name_km"
    t.string "name_en"
    t.string "personality_type"
    t.text "general_description"
    t.text "jd_main_task"
    t.string "jd_environment"
    t.string "jd_technology_skill"
    t.string "edu_education_level"
    t.string "edu_high_school_supported_subject"
    t.string "edu_higher_education_skill"
    t.string "qua_supported_knowledge"
    t.string "qua_supported_skill"
    t.string "qua_supported_capacity"
    t.string "qua_characteristic_of_job"
    t.text "info_job_market"
    t.text "info_similar_job"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "user"
    t.text "game"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "version"
  end

  create_table "major_mappings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "major_id"
    t.string "college_major_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "majors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "middle_schools", id: :string, limit: 8, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "province_id"
    t.string "district_id"
    t.string "commune_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "personal_understandings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "game_id"
    t.string "are_you_going_to_study_till_grade12"
    t.string "are_your_parents_allow_you_to_study_till_grade12"
    t.string "have_you_ever_thought_of_career"
    t.string "career_name"
    t.string "how_to_reach_career_goal"
    t.string "does_parents_agree_with"
    t.string "ever_talked_with_anyone_about_career"
    t.string "how_to_reach_job_vacancy"
    t.string "who_to_reach_job_vacancy"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "personalities", primary_key: "code", id: :string, limit: 36, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name_km"
    t.string "name_en"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_personalities_on_code", unique: true
  end

  create_table "personality_categories", primary_key: "code", id: :string, limit: 36, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name_en"
    t.string "name_km"
    t.string "group"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "personality_category_careers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "personality_category_code"
    t.string "career_code"
  end

  create_table "personality_category_personality_majors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "personality_category_code"
    t.string "personality_major_code"
  end

  create_table "personality_majors", primary_key: "code", id: :string, limit: 36, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name_en"
    t.string "name_km"
    t.string "basic_knowledge"
    t.string "study_credit"
    t.text "recieved_knowledge"
    t.text "possible_workplaces"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "personality_selections", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "personality_code"
    t.integer "personality_test_id"
  end

  create_table "personality_tests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "school_departments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "school_id"
    t.integer "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "school_majors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "major_id"
    t.integer "school_id"
    t.integer "department_id"
    t.integer "school_department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schools", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "logo"
    t.string "address"
    t.string "province"
    t.string "phone_numbers"
    t.string "faxes"
    t.string "emails"
    t.string "website_or_facebook"
    t.string "mailbox"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.integer "kind"
  end

  create_table "self_understanding_options", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "value"
    t.string "self_understanding_question_id"
    t.integer "display_order", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "self_understanding_questions", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "type"
    t.integer "display_order", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "self_understanding_responses", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "holland_quiz_id"
    t.string "self_understanding_question_id"
    t.string "self_understanding_question_code"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subject_tips", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "subject_code", null: false
    t.string "tip", null: false
    t.string "tip_type", null: false
  end

  create_table "subjects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "game_id", null: false
    t.string "khmer_reading"
    t.string "khmer_writing"
    t.string "english"
    t.string "math"
    t.string "social_study_ethics_and_citizenship"
    t.string "social_study_geography"
    t.string "social_study_history"
    t.string "science_physics"
    t.string "science_chemistry"
    t.string "science_biology"
    t.string "soft_skill_communication"
    t.string "soft_skill_brave"
    t.string "soft_skill_teamwork"
    t.string "soft_skill_problem_solving"
    t.string "soft_skill_public_speaking"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "uuid"
    t.string "full_name", null: false
    t.string "password", null: false
    t.string "username", null: false
    t.string "sex"
    t.date "date_of_birth"
    t.string "phone_number"
    t.string "school_name"
    t.string "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.string "high_school_code"
    t.string "province_id"
    t.string "district_id"
    t.string "commune_code"
    t.integer "class_group"
    t.integer "middle_school_id"
    t.string "device_id"
    t.integer "device_type"
    t.integer "device_os"
    t.integer "app_version"
    t.datetime "registered_at"
  end

  create_table "videos", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "url"
    t.string "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vocationals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
