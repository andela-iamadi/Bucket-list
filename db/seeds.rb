# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

U1 = User.create(full_name: "John Doe", email:"john.doey@gmail.com", password: "password", password_confirmation: "password")

I1 = U1.lists.create(name: "API tasks")

L1 = Item.create(name: "Create the tasks")
L2 = Item.create(name: "View the tasks")
L3 = Item.create(name: "Change the tasks")
L4 = Item.create(name: "Delete the tasks")

I1.items << [L1, L2, L3, L4]
