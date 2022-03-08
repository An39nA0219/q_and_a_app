# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


#  credentialするとmaster_keyとかが厄介なので平文にしておきます。
User.create(name: "admin", email: "admin@xxxx.co.jp", password: "admin", is_admin: true)