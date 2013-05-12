#!/usr/bin/ruby
require 'active_support/all'


fd = File.open("Compendium2.txt","r")

#A method to detect keys
def key_word?(line)
  k_list = [
    /^Skills:.*/ ,
    /^Note:.*/ ,
    /^Talents:.*/ ,
    /^Trappings:.*/ ,
    /^Career Entries:.*/ ,
    /^Career Exits:.*/ ,
    /^Career.*/ ,
    /^\*.*/ ,
    ]
  ret = false
  k_list.each do |reg|
    if (line =~ reg)
      ret = true
    end
  end
  return ret
end

#A method to detect trash lines
def trash?(line)
  trash_list = [
    /^\d+$/ ,
    /^Main Profile$/ ,
    /^Secondary Profile$/ ,
    /^WS$/ ,
    /^BS$/ ,
    /^S$/ ,
    /^T$/ ,
    /^Ag$/ ,
    /^Int$/ ,
    /^WP$/ ,
    /^Fel$/ ,
    /^A$/ ,
    /^W$/ ,
    /^SB$/ ,
    /^TB$/ ,
    /^M$/ ,
    /^Mag$/ ,
    /^IP$/ ,
    /^FP$/ ,
    /^$/
    ]
  ret = false
  trash_list.each do |reg|
    if (line =~ reg)
      ret = true
    end
  end
  return ret
end



###MAIN####

career_l = []

#Whate to find 
hash = Hash.new
in_state = Hash.new

#Enume creation
fd.each do |line|

  #New career init everything
  if ( line =~ /^Careers$/)
    #puts hash.to_yaml
    career_l << hash
    puts "=" * 80
    #Init var
    hash = Hash.new
    in_state = Hash.new
  #Name
  elsif ( line =~ /^cname: (.*)/ )
    hash[:name] = $1.chomp.capitalize
  #Access
  elsif ( line.downcase =~ /^basic/ or line.downcase =~ /^advanced/ )
    hash[:access] = line.chomp.capitalize
  #Profile
  elsif  ( line =~ /^\+\d+.*/ or line =~ /^-$/ )
    hash[:profile] ||= ""
    hash[:profile] += line.chomp + " "
  #Skills
  elsif ( line =~ /^Skills: (.*)/)
    hash[:skills] ||= ""
    hash[:skills] += $1
    in_state[:skills] = true
  #Talents
  elsif ( line =~ /^Talents: (.*)/)
    hash[:talents] ||= ""
    hash[:talents] += $1
    in_state[:talents] = true
    in_state[:skills] = false
  #Trapings
  elsif ( line =~ /^Trappings: (.*)/)
    hash[:trappings] ||= ""
    hash[:trappings] += $1
    in_state[:trappings] = true
    in_state[:talents] = false
  #Career Entries
  elsif ( line =~ /^Career Entries: (.*)/)
    hash[:entry] ||= ""
    hash[:entry] += $1
    in_state[:trappings] = false
    in_state[:entry] = true
  #Career Exits
  elsif ( line =~ /^Career Exits: (.*)/)
    hash[:next] ||= ""
    hash[:next] += $1
    in_state[:entry] = false
    in_state[:next] = true
  elsif trash?(line)
    #Remove every pending state
    in_state.keys.each do |k|
      in_state[k] = false
    end
  else 
    tmp = in_state.keys.select { |x| in_state[x]  }
    k = tmp.first
    if ( key_word?(line) )
      in_state[k] = false
      hash[:description] ||= ""
      hash[:description] += line.chomp+"\n"
    elsif (! k.nil? )
      hash[k] ||= ""
      hash[k] += line.chomp
    else
      hash[:description] ||= ""
      hash[:description] += line.chomp+"\n"
    end
  end
end

career_l << hash
fd.close

File.open("Compendium.yaml", "w+") do |f|
  f.write(career_l.to_yaml)
end
