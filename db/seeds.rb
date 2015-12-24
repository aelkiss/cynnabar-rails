# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

case Rails.env
when "development"
  # ensure there is an admin user
  admin = User.create(email: 'admin@example.com', password: 'password', role: :admin, name: 'Magister Administerio of Windfall Keep')
end
