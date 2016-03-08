# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

RegularUser.create!(   name: "Nishanth Vijayan" ,
                                  email: "nishanththegr8@gmail.com" ,
                                  password: "nishanthpassword",
                                  password_confirmation: "nishanthpassword",
                                  admin: true,
                                  manager: true)

RegularUser.create!(   name: "Abhishek Tiwari" ,
                                  email: "abhishektiwari@gmail.com" ,
                                  password: "tiwaripassword",
                                  password_confirmation: "tiwaripassword",
                                  admin: false,
                                  manager: true)

RegularUser.create!(   name: "Nitin Kumar" ,
                                  email: "nithinkumar@gmail.com" ,
                                  password: "nithinpassword",
                                  password_confirmation: "nithinpassword",
                                  admin: false,
                                  manager: false)

10.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  RegularUser.create!(name: name ,
                                 email: email ,
                                 password: "password",
                                 password_confirmation: "password")
end


GuestUser.create!( name: "Jitin Madhu", details: Faker::Lorem.paragraph, regular_user: RegularUser.second, from_date: Faker::Date.between(50.days.ago, Date.today), to_date: Faker::Date.between(50.days.ago, Date.today))
GuestUser.create!( name: "Himanshu Gupta" , details: Faker::Lorem.paragraph,regular_user: RegularUser.first, from_date: Faker::Date.between(50.days.ago, Date.today), to_date: Faker::Date.between(50.days.ago, Date.today) )
GuestUser.create!( name: "Jainedra Mandavi" , details: Faker::Lorem.paragraph,regular_user: RegularUser.second, from_date: Faker::Date.between(50.days.ago, Date.today), to_date: Faker::Date.between(50.days.ago, Date.today) )

3.times do |n|
  GuestUser.create!( name: Faker::Name.name, details: Faker::Lorem.paragraph,regular_user: RegularUser.first, from_date: Faker::Date.between(50.days.ago, Date.today), to_date: Faker::Date.between(50.days.ago, Date.today) )
  GuestUser.create!( name: Faker::Name.name, details: Faker::Lorem.paragraph,regular_user: RegularUser.second, from_date: Faker::Date.between(50.days.ago, Date.today), to_date: Faker::Date.between(50.days.ago, Date.today) )
  GuestUser.create!( name: Faker::Name.name, details: Faker::Lorem.paragraph,regular_user: RegularUser.third, from_date: Faker::Date.between(50.days.ago, Date.today), to_date: Faker::Date.between(50.days.ago, Date.today) )
end


Transaction.create!( food_type: "D", date: "2016-02-20", price: 40, guest_transaction: true, guest_user: GuestUser.first)
Transaction.create!( food_type: "L", date: "2016-02-22", price: 30, guest_transaction: true, guest_user: GuestUser.first)
Transaction.create!( food_type: "D", date: "2016-02-23", price: 40, regular_user: RegularUser.third)
Transaction.create!( food_type: "B", date: "2016-02-23", price: 20, guest_transaction: true, guest_user: GuestUser.first)
Transaction.create!( food_type: "B", date: "2016-02-24", price: 70, regular_user: RegularUser.second)
Transaction.create!( food_type: "S", date: "2016-02-24", price: 45, regular_user: RegularUser.fifth)
Transaction.create!( food_type: "S", date: "2016-02-24", price: 45, regular_user: RegularUser.third)