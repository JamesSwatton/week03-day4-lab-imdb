class Casting

  attr_accessor :movie_id, :star_id, :fee
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @movie_id = options['movie_id'].to_i
    @star_id = options['star_id'].to_i
    @fee = options['fee'].to_i
  end

  def save()
    sql = "INSERT INTO castings
    (
      movie_id,
      star_id,
      fee
    ) VALUES
    (
      $1, $2, $3
    ) RETURNING id"
    values = [@movie_id, @star_id, @fee]
    castings = SqlRunner.run(sql, values)
    @id = castings[0]['id'].to_i
  end

  def update()
    sql = "UPDATE castings SET (movie_id, star_id, fee) = ($1, $2, $3) WHERE id = $4"
    values = [@movie_id, @star_id, @fee, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM castings"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM castings"
    all_castings = SqlRunner.run(sql)
    return self.map_items(all_castings)
  end

  def self.map_items(casting_data)
    results = casting_data.map { |casting| Casting.new(casting) }
    return results
  end

end
