# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Restaurant.create(name: 'Mezze', cuisine: 'Vegetarian', rating: 0, ten_bis: false, address: "Ahad Ha'Am St 51, Tel Aviv-Yafo", max_delivery_time: 30, num_of_reviews: 0)
Restaurant.create(name: 'Allora', cuisine: 'Italian', rating: 0, ten_bis: false, address: 'Sderot Ben Gurion 39, Tel Aviv-Yafo', max_delivery_time: 55, num_of_reviews: 0)
Restaurant.create(name: 'Cafe Louise', cuisine: 'Cafe', rating: 0, ten_bis: true, address: 'Harugei Malkhut St 11, Tel Aviv-Yafo', max_delivery_time: 40, num_of_reviews: 0)
Restaurant.create(name: 'Wolfnights', cuisine: 'Hamburger', rating: 0, ten_bis: false, address: 'Yehuda HaMakkabbi St 53, Tel Aviv-Yafo', max_delivery_time: 100, num_of_reviews: 0)
Restaurant.create(name: 'Shalosh', cuisine: 'Salads', rating: 0, ten_bis: true, address: 'Ahuzat Bayit St 5, Tel Aviv-Yafo', max_delivery_time: 10, num_of_reviews: 0)