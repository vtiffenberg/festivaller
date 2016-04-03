# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless Event.count > 0
  c1 = Event.create name: 'Clases sábado', date: DateTime.new(2016,5,14,13,30)
  c2 = Event.create name: 'Clases domingo', date: DateTime.new(2016,5,15,13,30)
  f1 = Event.create name: 'Fiesta Rural Juke Joint', date: DateTime.new(2016,5,13,21)
  f2 = Event.create name: 'Fiesta Urban Barrelhouse', date: DateTime.new(2016,5,14,21)
  f3 = Event.create name: 'Fiesta Frenchmen St.', date: DateTime.new(2016,5,13,21)

  p = Pass.create name: 'Pase festival', price: '700'
  p.events << c1 << c2 << f1 << f2 << f3
  p = Pass.create name: 'Pase pareja', price: '1200'
  p.events << c1 << c2 << f1 << f2 << f3
  p = Pass.create name: 'Pase fiestas', price: '300'
  p.events << f1 << f2 << f3
  p = Pass.create name: 'Pase solo', price: '600'
  p.events << c1 << c2 << f1 << f2 << f3
  p = Pass.create name: 'Día festival - sábado', price: '500'
  p.events << c1 << f2
  p = Pass.create name: 'Día festival - domingo', price: '500'
  p.events << c2 << f3
  p = Pass.create name: 'Fiesta - viernes', price: '120'
  p.events << f1
  p = Pass.create name: 'Fiesta - sábado', price: '120'
  p.events << f2
  p = Pass.create name: 'Fiesta - domingo', price: '120'
  p.events << f3
end
