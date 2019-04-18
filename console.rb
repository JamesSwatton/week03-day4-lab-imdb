require_relative('./models/movie')
require_relative('./models/star')
require_relative('./models/casting')

Movie.delete_all()
Star.delete_all()
Casting.delete_all()

movie1 = Movie.new( {'title' => 'Jaws', 'genre' => 'disaster'} )
movie2 = Movie.new( {'title' => 'Dual', 'genre' => 'thriller'} )

star1 = Star.new( {'first_name' => 'Robert', 'last_name' => 'Shaw'} )
star2 = Star.new( {'first_name' => 'Roy', 'last_name' => 'Scheider'} )

movie1.save()
movie2.save()

star1.save()
star2.save()

casting1 = Casting.new( {'movie_id' => movie1.id, 'star_id' => star1.id, 'fee' => 100_000 })

casting1.save()

movie1.title = "Jaws 2"
movie1.update()

star1.first_name = "Richard"
star1.last_name = "Dreyfuss"
star1.update()

casting1.fee = 50_000
casting1.update()

# p movie1.stars()

# p Movie.all()
# p Star.all()
# p Casting.all()
