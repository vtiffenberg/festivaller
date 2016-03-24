require 'machinist/active_record'

Pass.blueprint do
  name { Faker::Book.publisher }
  price { [200,400,600].sample }
end

Event.blueprint do
  name { Faker::Book.title }
  date { Faker::Date.between(Date.today + 1.month, Date.today + 2.months) }
end

Registrant.blueprint do
  name { Faker::Name.name }
  email { Faker::Internet.email }
  pass
end
