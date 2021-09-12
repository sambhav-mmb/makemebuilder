# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AdminUser.create!(email: 'admin@makemebuilder.com', password: 'makemebuilder', password_confirmation: 'makemebuilder', role: 1)# if Rails.env.development?

Status.create!(code: 'c', name: 'Created', color: 'fff', bgcolor: '000', rank: 1, notes: "Created")
Status.create!(code: 'a', name: 'Active', color: '090', bgcolor: 'fff', rank: 2, notes: "Active")
Status.create!(code: 's', name: 'Suspended', color: '933', bgcolor: 'fff', rank: 3, notes: "Suspended")
Status.create!(code: 'n', name: 'Inactive/Canceled', color: '999', bgcolor: 'fff', rank: 4, notes: "Canceled")
Status.create!(code: 'h', name: 'Hidden', color: 'fff', bgcolor: '000', rank: 5, notes: "Hidden")
Status.create!(code: 'd', name: 'Deleted', color: 'fff', bgcolor: '000', rank: 6, notes: "Deleted")
Setting.create(checkout_terms: "I agree that this is an enquiry only, \"Not a Quota...", meta_title: "MakeMeBuilder(MMB): Best Interior Designer Delhi|N...", meta_description: "We provide comprehensive Interior design solutions...", meta_keywords: "Make Me Builder, \r\nhome renovation in Gurgaon,\r\nth...")