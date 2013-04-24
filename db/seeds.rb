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


