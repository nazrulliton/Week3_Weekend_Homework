require_relative("../db/sql_runner")
require_relative("film")
require_relative("customer")

class Ticket

attr_accessor :customer_id, :film_id
attr_reader :id

def initialize(options)
@customer_id = options['customer_id'].to_i
@film_id = options['film_id'].to_i
@id = options['id'].to_i if options['id']
end

def save()
   sql = "INSERT INTO tickets(
   customer_id,
   film_id)
   VALUES ($1,$2)
   RETURNING id;"
   values = [@customer_id, @film_id]
   ticket = SqlRunner.run(sql,values).first
   @id = ticket['id'].to_i
end

def update()
    sql = "UPDATE tickets SET customer_id = $1, film_id = $2 WHERE id = $3"
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

def self.all()
  sql = "SELECT * FROM tickets"
  tickets = SqlRunner.run(sql)
  result = tickets.map { |ticket| Ticket.new( ticket ) }
  return result
end


def self.delete_all()
  sql = "DELETE FROM tickets"
  SqlRunner.run(sql)
end




end
