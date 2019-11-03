require_relative("../db/sql_runner")

class Film

attr_accessor :title, :price
attr_reader :id

def initialize(options)
  @title = options['title']
  @price = options['price'].to_i
  @id = options['id'].to_i if options['id']

end

def save()
   sql = "INSERT INTO films(
   title,
   price)
   VALUES ($1,$2)
   RETURNING id;"
   values = [@title, @price]
   film = SqlRunner.run(sql,values).first
   @id = film['id'].to_i
end

def update()
    sql = "UPDATE films SET title = $1, price = $2 WHERE id = $3"
    values = [@title,@price, @id]
    SqlRunner.run(sql, values)
  end

  def customer()
    sql = "SELECT customers.name
    FROM customers
    INNER JOIN tickets
    on customers.id = tickets.customer_id
    WHERE film_id = $1;"
    values = [@id]
    customer = SqlRunner.run(sql,values)
    return customer.map{|customer| Customer.new(customer)}
  end

def screening()
  sql = "SELECT screenings.show_time
  FROM screenings

  WHERE film_id = $1;"
  values = [@id]
  screening = SqlRunner.run(sql,values)
  return screening.map{|screening| Screening.new(screening)}
end



def self.all()
  sql = "SELECT * FROM films"
  films = SqlRunner.run(sql)
  result = films.map { |film| Film.new( film ) }
  return result
end



def self.delete_all()
  sql = "DELETE FROM films;"
  SqlRunner.run(sql)
end




end
