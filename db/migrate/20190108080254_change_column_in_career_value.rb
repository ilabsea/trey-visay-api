class ChangeColumnInCareerValue < ActiveRecord::Migration[5.1]
  def change
    category = Characteristic.find_by(title: "បុគ្គលិកលក្ខណៈបុគ្គល បែបសង្គម")
    careerTitles = ["អ្នកថែទាំកុមារ", "គ្រូបង្រៀនជនពិការ", "អ្នកបណ្ដុះបណ្ដាលវិជ្ជាជីវៈ"]

    careers = Career.where(name: careerTitles)
    return if careers.empty?

    careers.update_all(categorizable_type: "Characteristic", categorizable_id: category.id)
 end
end
