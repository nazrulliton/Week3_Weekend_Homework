require_relative("../db/sql_runner.rb")

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
  @name = options['name']
  @funds = options['funds'].to_i
  @id = options['id'].to_i if options['id']
  end

def save()
   sql = "INSERT INTO customers(
   name,
   funds)
   VALUES ($1,$2)
   RETURNING id;"
   values = [@name, @funds]
   customer = SqlRunner.run(sql,values).first
   @id = customer['id'].to_i
end

def update()
    sql = "UPDATE customers SET name = $1, funds = $2 WHERE id = $3"
    values = [@name,@funds, @id]
    SqlRunner.run(sql, values)
  end

def film()
  sql = "SELECT films.title
  FROM films
  INNER JOIN tickets
  ON films.id = tickets.film_id
  WHERE customer_id = $1;"
  values = [@id]
  film = SqlRunner.run(sql,values)
  return film.map{|film| Film.new(film)}
end

def remaining_funds()
sql = "SELECT SUM(price) AS total
      FROM films
      INNER JOIN tickets
      ON films.id = tickets.film_id
      WHERE customer_id = $1"
      values = [@id]
      result = SqlRunner.run(sql, values).first
      return @funds - result['total'].to_i()
    end



def self.all()
  sql = "SELECT * FROM customers"
  customers = SqlRunner.run(sql)
  result = customers.map { |customer| Customer.new( customer ) }
  return result
end


def self.delete_all()
  sql = "DELETE FROM customers;"
   SqlRunner.run(sql)
end

end
