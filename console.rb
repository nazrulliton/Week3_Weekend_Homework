require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require_relative('models/screenings')

require('pry-byebug')


Ticket.delete_all()
Screening.delete_all()
Customer.delete_all()
Film.delete_all()


customer_1 = Customer.new({
  'name' => 'Jon Jones',
  'funds' => 1500
  })
customer_1.save()

customer_2 = Customer.new({
  'name' => 'Daniel Cormier',
  'funds' => 100
  })
customer_2.save()

customer_3 = Customer.new({
  'name' => 'Aubrey Drake',
  'funds' => 1400
  })
customer_3.save()

film_1  = Film.new({
  'title'  => 'star wars:2',
  'price' => 5
  })
  film_1.save()

  film_2 = Film.new({
    'title' => 'South Park',
    'price' => '6'
    })
    film_2.save()


  ticket_1 = Ticket.new({
    'customer_id' => customer_1.id,
    'film_id' => film_1.id
    })
    ticket_1.save()

    ticket_2 = Ticket.new({
      'customer_id' => customer_1.id,
      'film_id' => film_2.id
      })
      ticket_2.save()

    ticket_3 = Ticket.new({
        'customer_id' => customer_2.id,
        'film_id' => film_2.id
        })
        ticket_3.save()

    ticket_4 = Ticket.new({
          'customer_id' => customer_3.id,
          'film_id' => film_2.id
          })
          ticket_4.save()

          ticket_5 = Ticket.new({
            'customer_id' => customer_3.id,
            'film_id' => film_1.id
            })
            ticket_5.save()

    screening_1 = Screening.new({
      'show_time' => '1 pm',
      'film_id' => film_1.id
      })
      screening_1.save()

      screening_2 = Screening.new({
        'show_time' => '4 pm',
        'film_id' => film_2.id
        })

        screening_2.save()


binding.pry

nil
