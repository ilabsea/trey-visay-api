# frozen_string_literal: true

# == Schema Information
#
# Table name: characteristics
#
#  id               :bigint(8)        not null, primary key
#  title            :string(255)      not null
#  description      :text(65535)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  concern_subjects :text(65535)
#

FactoryBot.define do
  factory :characteristic do
    title { FFaker::Name.name }
    description { FFaker::Name.name }

    trait :science do
      id           { 1 }
      title        { "បុគ្គលិកលក្ខណៈបុគ្គលបែប វិទ្យាសាស្រ្ត" }
      description  { "បុគ្គលដែលជ្រើសរើសមុខរបរ បែបវិទ្យាសាស្រ្ត គឺចូលចិត្តសិក្សាស្រាវជ្រាវ  មានចំងល់ច្រើន គិតបែបស៊ីជំរៅប្រាកដប្រជា មានមហិច្ឆិតា​ ទទួលសុខត្រូវខ្ពស់ និងមានភាពជាអ្នកដឹកនាំ។ គាត់/នាង ចាប់អារម្មណ៍ និងរៀនពូកែមុខវិជ្ជា គណិតវិទ្យា រូបវិទ្យា គីមីវិទ្យា ជីវវិទ្យា និងភាសាបរទេសជាដើម ។ ដើម្បីទទួលបាន អាជីពបែបវិទ្យាសាស្រ្ត សិស្សានុសិស្ស ត្រូវសិក្សា​រយៈពេលពី ៤-៦ ឆ្នាំនៅសាកលវិទ្យាល័យ តាមជំនាញដែលខ្លួនជ្រើសរើស ។ ឱកាសការងារ គឺមាននៅតាមស្ថាប័នរដ្ឋ អង្គការក្រៅរដ្ឋាភិបាល ក្រុមហ៊ុនឯកជន ឬបង្កើតអាជីវកម្មផ្ទាល់ខ្លួន។" }
    end

    trait :technical do
      id          { 2 }
      title       { "បុគ្គលិកលក្ខណៈបុគ្គលបែប បច្ចេកទេស" }
      description { "បុគ្គលដែលជ្រើសរើសមុខរបរ បែបបច្ចេកទេស មានគំនិតច្នៃប្រឌិត មានទំនុកចិត្ត  ឆ្លាត មានឆន្ទៈ ច្បាស់លាស់នឹងការងារ ។ គាត់/នាង ចាប់អារម្មណ៍ និងរៀនពូកែមុខវិជ្ជា គណិតវិទ្យា រូបវិទ្យា និងភាសាបរទេសជាដើម។ ដើម្បីទទួលបាន អាជីពបែបបច្ចេកទេស សិស្សានុសិស្ស ត្រូវសិក្សា​រយៈពេលពី ២-៤ ឆ្នាំនៅសាកលវិទ្យាល័យ ឬវិទ្យាស្ថានតាមជំនាញដែលខ្លួនជ្រើសរើស ។ ឱកាសការងារ គឺមាននៅតាមស្ថាប័នរដ្ឋ អង្គការក្រៅរដ្ឋាភិបាល ធនាគារ ក្រុមហ៊ុនឯកជន ឬបង្កើតអាជីវកម្មផ្ទាល់ខ្លួន។" }
    end

    trait :social do
      id          { 3 }
      title       { "បុគ្គលិកលក្ខណៈបុគ្គល បែបសង្គម" }
      description { "បុគ្គលដែលជ្រើសរើសមុខរបរ បែបសង្គម ចូលចិត្តធ្វើការជាមួយមនុស្ស  មានការអត់ធ្មត់  ពូកែសម្របសម្រួល មានទំនួលខុសត្រូវ  និងមានទំនាក់ទំនងល្អជាមួយក្រុមការងារ និងក្នុងសហគមន៍។ គាត់/នាង ចាប់អារម្មណ៍ និងរៀនពូកែមុខវិជ្ជា ភាសាខ្មែរ/អក្សរសាស្រ្តខ្មែរ  ភូមិវិទ្យា  សីលធម៌ និងភាសាបរទេសជាដើម។ ដើម្បីទទួលបាន អាជីពបែបសង្គម សិស្សានុសិស្ស ត្រូវសិក្សា​រយៈពេលពី ២-៤ ឆ្នាំនៅសាកលវិទ្យាល័យ ឬវិទ្យាស្ថានតាមជំនាញដែលខ្លួនជ្រើសរើស ។ឱកាសការងារ គឺមាននៅតាមស្ថាប័នរដ្ឋ អង្គការក្រៅរដ្ឋាភិបាល ធនាគារ  សណ្ឋាគារ ឬបង្កើតអាជីវកម្មផ្ទាល់ខ្លួន។" }
    end

    trait :with_careers do
      after(:create) do |characteristic, evaluator|
        careers = ["វិស្វករសំណង់ស៊ីវិល", "អ្នកគីមីវិទ្យា", "វិស្វករអឡិចត្រូនិច", "ទន្តពេទ្យ", "អ្នកបើកយន្តហោះ"]
        careers.each do |career|
          characteristic.careers.create(name: career)
        end
      end
    end

    trait :with_entries do
      after(:create) do |characteristic, evaluator|
        entries = ["មានទំនាក់ទំនងល្អជាមួយនឹងក្រុមការងារ", "ស្រាវជ្រាវ", "ឯករាជ្យ", "មហិច្ឆតា", "មានទំនុកចិត្ត", "មានផែនការ និងគៅដៅច្បាស់លាស់", "ហ្មត់ចត់នឹងការងារ", "មានទេពកោសល្យ", "មានចម្ងល់ជារឿយ", "មានទំនួលខុសត្រូវ", "គិតស៊ីជំរៅ និងមានហេតុផល", "ប្រាកដប្រជា", "ជាបុគ្គលឆ្នើម", "មានស្មារតីប្រុងប្រយត្ន័", "មានភាពជាអ្នកដឹកនាំ និងគ្រប់គ្រង", "អនុវត្តន៍ការងារជាក់ស្តែង", "គ្រប់គ្រងពេលវេលា​បានល្អ", "មានក្រមវិន័យល្អ", "មានឆន្ទៈ", "ឆ្លាត", "ចូលចិត្តវិទ្យាសាស្រ្ត", "មានគំនិតច្នៃប្រឌិត", "ចូលចិត្តធ្វើការជាមួយ នឹងបច្ចេកវិទ្យា និង គ្រឿងម៉ាស៊ីន", "មានដំណោះស្រាយល្អ", "ពូកែចរចារ", "ចេះសម្របខ្លួនតាមស្ថានភាពជាក់ស្ដែង", "អត់ធ្មត់", "ពូកែសម្របសម្រួល", "ចូលចិត្តធ្វើការជាមួយមនុស្ស", "ស្លូតបូត និងសុភាពរាបសារ", "ជួយផ្ដល់យោបល់ឲ្យអ្នកដទៃ", "ចូលចិត្តទទួលការរិៈគន់ក្នុងន័យស្ថាបនា", "ចេះចែករំលែកបទពិសោធន៍ការងារ និងចំណេះដឹង", "មានប្រាស្រ័យល្អក្នុងសហគមន៍", "រួសរាយរាក់ទាក់"]
        entries.each do |entry|
          characteristic.entries.create(name: entry)
        end
      end
    end
  end
end
