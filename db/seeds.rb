# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: "mh152235@fh-muenster.de", username: "Matthias", password: 123456, password_confirmation: 123456, role: "product_owner")
User.create(email: "muh@kuh.de", username: "MuhKuh", password: 123456, password_confirmation: 123456)
User.create(email: "papa@schlumpf.de", username: "Papa Schlumpf", password: 123456, password_confirmation: 123456)
User.create(email: "jake@at.de", username: "Jake the dog", password: 123456, password_confirmation: 123456)
User.create(email: "finn@at.de", username: "Finn the human", password: 123456, password_confirmation: 123456)
User.create(username: "admin", email: "a@b.de", password: 123456, password_confirmation: 123456)