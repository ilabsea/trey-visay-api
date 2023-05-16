# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
a = Characteristic.find_by_title("បុគ្គលិកលក្ខណៈបុគ្គលបែប វិទ្យាសាស្រ្ត")
a.concern_subjects = [ "គណិតវិទ្យា", "រូបវិទ្យា", "គីមីវិទ្យា", "ជីវៈវិទ្យា", "ភាសារអង់គ្លេស/ភាសារបារាំង", "ក្លាហាន", "ដោះស្រាយបញ្ហា", "ការនិយាយជាសាធារណៈ"]
a.save!

a = Characteristic.find_by_title("បុគ្គលិកលក្ខណៈបុគ្គលបែប បច្ចេកទេស")
a.concern_subjects = [ "គណិតវិទ្យា", "រូបវិទ្យា", "ភាសារអង់គ្លេស/ភាសារបារាំង", "ក្លាហាន", "ដោះស្រាយបញ្ហា", "ការនិយាយជាសាធារណៈ"]
a.save!

a = Characteristic.find_by_title("បុគ្គលិកលក្ខណៈបុគ្គល បែបសង្គម")
a.concern_subjects = ["ការអានភាសារខ្មែរ", "ការសរសេរភាសារខ្មែរ", "ភូមិវិទ្យា", "សីលធម៌ និង ពលរដ្ឋ", "ភាសារអង់គ្លេស/ភាសារបារាំង", "ទំនាក់ទំនង", "ក្លាហាន", "ដោះស្រាយបញ្ហា", "ការនិយាយជាសាធារណៈ"]
a.save!
