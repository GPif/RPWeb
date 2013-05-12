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
require 'yaml'

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

careers = YAML::load_file( "db/Careers.yaml" ) 
careers.each do |car|
  puts car[:name]
  c = Career.new
  c.name = car[:name].to_s.chomp

  c.ws = car[:ws]
  c.bs = car[:bs]
  c.s  = car[:s]
  c.t  = car[:t]
  c.ag = car[:ag]
  c.int= car[:int]
  c.wp = car[:wp]
  c.fel= car[:fel]
  c.a  = car[:a]
  c.w  = car[:w]
  c.sb = car[:sb]
  c.tb = car[:tb]
  c.m  = car[:m]
  c.mag= car[:Mag]
  c.ip = car[:ip]
  c.fp = car[:fp]

  c.description = car[:description]
  c.skills_desc = car[:skills_desc]
  c.talents_desc = car[:talents_desc]
  c.trappings_desc = car[:trappings_desc]
  c.entry_desc = car[:entry_desc]
  c.exit_desc = car[:next_desc]
  c.save
end


puts "Compute next career"
careers = YAML::load_file( "db/Careers.yaml" ) 
careers.each do |car|
  puts car[:name]
  c = Career.find_by_name(car[:name])
  if (! car[:next].nil?) 
    car[:next].each do |n|
      puts "looking for #{n}"
      nc = Career.find_by_name(n.capitalize)
      c.next_career << nc
    end
  end
 c.save
end



