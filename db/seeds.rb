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

puts "==Competence=="
require File.expand_path(File.dirname(__FILE__))+"/seeds/competence.rb"

puts "==Talents=="
require File.expand_path(File.dirname(__FILE__))+"/seeds/talent.rb"

puts "==Race=="
require File.expand_path(File.dirname(__FILE__))+"/seeds/race.rb"

puts "==Career=="
require File.expand_path(File.dirname(__FILE__))+"/seeds/career.rb"
