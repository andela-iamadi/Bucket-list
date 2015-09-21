# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

U1 = User.create(full_name: "John Doe", email:"john.doe@gmail.com", password: "password", password_confirmation: "password")

I1 = U1.items.create(name: "API tasks")

L1 = List.create(name: "Create the tasks")
L2 = List.create(name: "View the tasks")
L3 = List.create(name: "Change the tasks")
L4 = List.create(name: "Delete the tasks")

I1.lists << [L1, L2, L3, L4]
