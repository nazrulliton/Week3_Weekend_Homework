require_relative("../db/sql_runner")
require_relative("film")
require_relative("customer")
require_relative("ticket")

class Screening

  attr_reader :id
  attr_accessor :show_time, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @show_time = options['show_time']
    @film_id = options['film_id'].to_i
  end


  def save()
     sql = "INSERT INTO screenings(
     show_time,
     film_id)
     VALUES ($1,$2)
     RETURNING id;"
     values = [@show_time, @film_id]
     screening = SqlRunner.run(sql,values).first
     @id = screening['id'].to_i
  end

  def update()
      sql = "UPDATE screenings
      SET show_time = $1, film_id = $2
      WHERE id = $3"
      values = [@show_time, @film_id, @id]
      SqlRunner.run(sql, values)
    end

  def self.all()
    sql = "SELECT * FROM screenings"
    screenings = SqlRunner.run(sql)
    result = screenings.map { |ticket| Ticket.new( ticket ) }
    return result
  end


  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end








end
