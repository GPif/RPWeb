#! ruby
require 'yaml'

careers = Array.new


File.open('Compendium.yaml') do |yf|
  YAML.load_documents( yf ) do |ydoc|
    ydoc.each do |car| 
      car_h = Hash.new
      #Name
      car_h[:name] = car[:name].to_s
      #Description
      car_h[:description] = car[:description].to_s
      #Profile parse
      tmp = car[:profile].to_s
      p = tmp.split(' ')
      car_h[:ws] = p[0].to_i
      car_h[:bs] = p[1].to_i
      car_h[:s]  = p[2].to_i
      car_h[:t]  = p[3].to_i
      car_h[:ag] = p[4].to_i
      car_h[:int]= p[5].to_i
      car_h[:wp] = p[6].to_i
      car_h[:fel]= p[7].to_i
      car_h[:a]  = p[8].to_i
      car_h[:w] =  p[9].to_i
      car_h[:sb] = p[10].to_i
      car_h[:tb] = p[11].to_i
      car_h[:M]  = p[12].to_i
      car_h[:Mag]= p[13].to_i
      car_h[:ip] = p[14].to_i
      car_h[:fp] = p[15].to_i
      #Access
      car_h[:access] = car[:access].to_s
      #Skills
      tmp = car[:skills].to_s
      s = tmp.split(/\s*,\s*/)
      car_h[:skills_desc] = tmp
      car_h[:skills] = s
      #Talents
      tmp = car[:talents].to_s
      t = tmp.split(/\s*,\s*/)
      car_h[:talents_desc] = tmp
      car_h[:talents] = t
      #Trapping 
      tmp = car[:trappings].to_s
      t = tmp.split(/\s*,\s*/)
      car_h[:trappings_desc] = tmp
      car_h[:trappings] = t
      #Entry   
      tmp = car[:entry].to_s
      t = tmp.split(/\s*,\s*/)
      car_h[:entry_desc] = tmp
      car_h[:entry] = t
      #Next 
      tmp = car[:next].to_s
      t = tmp.split(/\s*,\s*/)
      car_h[:next_desc] = tmp
      car_h[:next] = t
    
      puts car_h
      careers << car_h 
    end
  end
end


File.open("Careers.yaml", "w+") do |f|
  f.write(careers.to_yaml)
end
