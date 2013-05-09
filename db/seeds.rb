# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'
require 'database_cleaner'
require 'rexml/document'
include REXML

DatabaseCleaner.strategy = :truncation

# then, whenever you need to clean the DB
DatabaseCleaner.clean


##User
puts 'DEFAULT USERS'
user = User.find_or_create_by_login :login => ENV['ADMIN_LOGIN'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.login

##Carreer
puts 'BASE RACE'
rac = Race.find_or_create_by_name :name => 'Nain'
puts 'Race : ' << rac.name
rac = Race.find_or_create_by_name :name => 'Elfe'
puts 'Race : ' << rac.name
rac = Race.find_or_create_by_name :name => 'Halfling'
puts 'Race : ' << rac.name
rac = Race.find_or_create_by_name :name => 'Humain de l\'Empire'
puts 'Race : ' << rac.name

##Competence
puts "Delete all"
Competence.delete_all

puts "Insert Competences"

#CSV.foreach( "db/competence_seed.csv" , :col_sep => ';' , :headers => true) do |row|
#        rh = row.to_hash
#        c = Competence.new
#        c.name = rh['name']
#        c.base = (rh['base'] == "true")
#        c.characteristic = rh['cara']
#        c.description  = rh['desc']
#        c.save
#	puts "Name : " << c.name
#end

doc = Document.new(File.new("db/competences.xml"))
root = doc.root
root.each_element('//competence') do |c|
  #comp = Competence.find_by_name(c.elements['title'].text)
  comp = Competence.new
  comp.name = c.elements['title'].text
  comp.base = (c.elements['base'].text == "true")
  comp.description = c.elements['description'].text
  comp.characteristic = c.elements['cara'].text
  comp.save
  puts "Name : " << comp.name
end


##Talent
puts "Delete Talents"
Talent.delete_all

puts "Insert Talent"
doc = Document.new(File.new("db/talents.xml"))
root = doc.root
root.each_element('//talent') do |t|
  tal = Talent.new
  tal.name = t.elements['title'].text
  tal.description = t.elements['description'].text
  puts "save #{tal.name}"
  tal.save
end

##Career
puts "Delete Career"
Career.delete_all

puts "Insert Career"
doc = Document.new(File.new("db/compendium.xml"))
root = doc.root
root.each_element('//career') do |t|
  car = Career.new
  car.name = t.elements['name'].text
  car.ws = t.elements['ws'].text.to_i
  car.bs = t.elements['bs'].text.to_i
  car.s  = t.elements['s'].text.to_i
  car.t  = t.elements['t'].text.to_i
  car.ag = t.elements['ag'].text.to_i
  car.int= t.elements['int'].text.to_i
  car.wp = t.elements['wp'].text.to_i
  car.fel= t.elements['fel'].text.to_i
  car.a  = t.elements['a'].text.to_i
  car.w  = t.elements['w'].text.to_i
  car.sb = t.elements['sb'].text.to_i
  car.tb = t.elements['tb'].text.to_i
  car.m  = t.elements['m'].text.to_i
  car.mag= t.elements['mag'].text.to_i
  car.ip = t.elements['ip'].text.to_i
  car.fp = t.elements['fp'].text.to_i
  puts "save #{car.name}"
  car.save
end

puts "Compute next career"
root.each_element('//career') do |t|
  puts "Looking for " + t.elements['name'].text
  car = Career.find_by_name(t.elements['name'].text)
  puts "found : " + car.name
  t.elements['exit'].each_element('exit') do |ex|
    puts "next career search: " + ex.text.capitalize
    ne = Career.find_by_name(ex.text.capitalize)
    puts "next career found: " + ne.name
    car.next_career << ne
  end
  puts "save #{car.name}"
  car.save
end



