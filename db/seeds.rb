# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# All the current data is only for demo purposes and would obviously be removed before final deployment

RegularUser.create!(name: 'Nishanth Vijayan',
                    email: 'nishanth@gmail.com',
                    password: 'nishanthpassword',
                    password_confirmation: 'nishanthpassword',
                    admin: true,
                    manager: true)

RegularUser.create!(name: 'Abhishek Tiwari',
                    email: 'abhishektiwari@gmail.com',
                    password: 'tiwaripassword',
                    password_confirmation: 'tiwaripassword',
                    admin: false,
                    manager: true)

RegularUser.create!(name: 'Nitin Kumar',
                    email: 'nitinkumar@gmail.com',
                    password: 'nitinpassword',
                    password_confirmation: 'nitinpassword',
                    admin: false,
                    manager: false)

10.times do |_n|
  name = Faker::Name.name
  email = Faker::Internet.email
  RegularUser.create!(name: name,
                      email: email,
                      password: 'password',
                      password_confirmation: 'password')
end

GuestUser.create!(name: 'Jitin Madhu', details: Faker::Lorem.paragraph, regular_user: RegularUser.second,
                  from_date: Faker::Date.between(20.days.ago, Date.today), to_date: Faker::Date.between(Date.today, 20.days.from_now))
GuestUser.create!(name: 'Himanshu Gupta', details: Faker::Lorem.paragraph, regular_user: RegularUser.first,
                  from_date: Faker::Date.between(20.days.ago, Date.today), to_date: Faker::Date.between(Date.today, 20.days.from_now))
GuestUser.create!(name: 'Jainedra Mandavi', details: Faker::Lorem.paragraph, regular_user: RegularUser.second,
                  from_date: Faker::Date.between(20.days.ago, Date.today), to_date: Faker::Date.between(Date.today, 20.days.from_now))

3.times do |_n|
  GuestUser.create!(name: Faker::Name.name, details: Faker::Lorem.paragraph, regular_user: RegularUser.first,
                    from_date: Faker::Date.between(20.days.ago, Date.today), to_date: Faker::Date.between(Date.today, 20.days.from_now))
  GuestUser.create!(name: Faker::Name.name, details: Faker::Lorem.paragraph, regular_user: RegularUser.second,
                    from_date: Faker::Date.between(20.days.ago, Date.today), to_date: Faker::Date.between(Date.today, 20.days.from_now))
  GuestUser.create!(name: Faker::Name.name, details: Faker::Lorem.paragraph, regular_user: RegularUser.third,
                    from_date: Faker::Date.between(20.days.ago, Date.today), to_date: Faker::Date.between(Date.today, 20.days.from_now))
end

10.times do |_n|
  Transaction.create!(food_type: %w(B D L S).sample, date: Faker::Date.between(20.days.ago, 20.days.from_now), price: rand(30..120), guest_transaction: true, guest_user_id: rand(1..12))
  Transaction.create!(food_type: %w(B D L S).sample, date: Faker::Date.between(20.days.ago, 20.days.from_now), price: rand(30..120), guest_transaction: false, regular_user_id: rand(1..12))
end

SingleValue[:manager_password] = '123456789'
