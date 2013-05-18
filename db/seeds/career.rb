 
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
  c.m  = car[:M]
  c.mag= car[:Mag]
  c.ip = car[:ip]
  c.fp = car[:fp]

  c.access = car[:access]

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

