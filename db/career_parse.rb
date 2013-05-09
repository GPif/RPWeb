#!/usr/bin/ruby
require 'active_support/all'

def arr2profile (arr)
  hash = {
    :ws  => arr[0] ,
    :bs  => arr[1] ,
    :s   => arr[2] ,
    :t   => arr[3] ,
    :ag  => arr[4] ,
    :int => arr[5] ,
    :wp  => arr[6] ,
    :fel => arr[7] ,
    :a   => arr[8] ,
    :w   => arr[9] ,
    :sb  => arr[10] ,
    :tb  => arr[11] ,
    :m   => arr[12] ,
    :mag => arr[13] ,
    :ip  => arr[14] ,
    :fp  => arr[15] 
  }
  return hash
end

fd = File.open("compendium.txt","r")
e = fd.each
 while true 
  begin
    line = e.next
  rescue StopIteration
    break
  end
#New career
  if ( line =~ /^Careers$/)
    line = e.next
    line = e.next
    #New carrer detected init hash
    hash = { :name => line.capitalize.chomp }
    profile = []
  end
#Detect Profile
  if ( line =~ /^\+.*/ or line =~ /^-$/ )
    line.split(/\s/).each do |s|
      profile << s
    end
  if ( profile.length == 16 ) 
     tmp = arr2profile(profile)
     hash = hash.merge(tmp)
     # puts hash.inspect
    end
  end
#Skills
  if ( line =~ /^Skills: (.*)/)
    skill_str = $1.chomp
    while true
      line = e.next
      if ( line =~ /^Talents:/ )
	break
      else
	skill_str += line.chomp
      end
    end
    hash[:skills_desc] =  skill_str
  end
#Talents
  if ( line =~ /^Talents: (.*)/)
    tal_str = $1.chomp
    while true
      line = e.next
      if ( line =~ /^Trappings:/ )
	break
      else
	tal_str += line.chomp
      end
    end
    hash[:talents_desc] =  tal_str
  end
#Trappings
  if ( line =~ /^Trappings: (.*)/)
    trap_str = $1.chomp
    while true
      line = e.next
      if ( line =~ /^Career Entries:/ )
	break
      else
	trap_str += line.chomp
      end
    end
    hash[:trappings_desc] =  trap_str
  end
#Career Entries
  if ( line =~ /^Career Entries: (.*)/)
    car_en_str = $1.chomp
    while true
      line = e.next
      if ( line =~ /^Career Exits:/ )
	break
      else
	car_en_str += line.chomp
      end
    end
    hash[:entry_desc] = car_en_str
  end
  if ( line =~ /^Career Exits: (.*)/)
    car_ex_str = $1.chomp
    while true
      line = e.next
      if ( line =~ /^$/ )
	break
      else
	car_ex_str += line.chomp
      end
    end
    hash[:exit_desc] = car_ex_str
    hash[:exit] = []
    car_ex_str.split(/\s*,\s*/).each do |car|
      hash[:exit] << car
    end
    puts hash.to_xml(:root => 'career')
  end
end
fd.close
