class Star

  attr_accessor :first_name, :last_name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def save()
    sql = "INSERT INTO stars
    (
      first_name,
      last_name
    ) VALUES
    (
      $1, $2
    ) RETURNING id"
    values = [@first_name, @last_name]
    stars = SqlRunner.run(sql, values)
    @id = stars[0]['id'].to_i
  end

  def update()
    sql = "UPDATE stars SET (first_name, last_name) = ($1, $2) WHERE id = $3"
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM stars"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM stars"
    all_stars = SqlRunner.run(sql)
    return self.map_items(all_stars)
  end

  def self.map_items(star_data)
    results = star_data.map { |star| Star.new(star) }
    return results
  end

end
