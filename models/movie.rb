require_relative('../db/sql_runner')
require_relative('./star')


class Movie

  attr_accessor :title, :genre
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
  end

  def save()
    sql = "INSERT INTO movies
    (
      title,
      genre
    ) VALUES
    (
      $1, $2
    ) RETURNING id"
    values = [@title, @genre]
    movies = SqlRunner.run(sql, values)
    @id = movies[0]['id'].to_i
  end

  def update()
    sql = "UPDATE movies SET (title, genre) = ($1, $2) WHERE id = $3"
    values = [@title, @genre, @id]
    SqlRunner.run(sql, values)
  end

  # def stars()
  #   sql = "SELECT * FROM stars WHERE id = $1"
  #   values = [@id]
  #   stars_in_movie = SqlRunner.run(sql, values)
  #   return Star.map_items(stars_in_movie)
  # end

  def self.delete_all()
    sql = "DELETE FROM movies"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM movies"
    all_movies = SqlRunner.run(sql)
    return self.map_items(all_movies)
  end

  def self.map_items(movie_data)
    results = movie_data.map { |movie| Movie.new(movie) }
    return results
  end

end
