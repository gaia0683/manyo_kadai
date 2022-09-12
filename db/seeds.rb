# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:'bomu',email:'bomu@bomu.com',password:'password',password_confirmation:'password',admin_user:'true')
User.create!(name:'kimu',email:'kinu@kinu.com',password:'password',password_confirmation:'password',admin_user:'true')
