#encoding: utf-8

##Race
Race.delete_all

puts 'BASE RACE'
rac = Race.create :id => 1, :name => 'Nain'
puts 'Race : ' << rac.name
rac = Race.create :id => 2, :name => 'Elfe'
puts 'Race : ' << rac.name
rac = Race.create :id => 3, :name => 'Halfing'
puts 'Race : ' << rac.name
rac = Race.create :id => 4, :name => 'Humain de l\'Empire'
puts 'Race : ' << rac.name

#Native profile

t = [
      [ 30 , 20 , 20 , 30 , 10 , 20 , 20 , 10 , 1 , 3 , 0 , 0] ,
      [ 20 , 30 , 20 , 20 , 30 , 20 , 20 , 20 , 1 , 5 , 0 , 0] ,
      [ 10 , 30 , 10 , 10 , 30 , 20 , 20 , 30 , 1 , 4 , 0 , 0] ,
      [ 20 , 20 , 20 , 20 , 20 , 20 , 20 , 20 , 1 , 4 , 0 , 0] ,
    ]

i=1
t.each do |r|
  NativeProfile.create ({
    :race_id => i     ,
    :ws      => t[i-1][0]  ,
    :bs      => t[i-1][1]  ,
    :s       => t[i-1][2]  ,
    :t       => t[i-1][3]  ,
    :ag      => t[i-1][4]  ,
    :int     => t[i-1][5]  ,
    :wp      => t[i-1][6]  ,
    :fel     => t[i-1][7]  ,
    :a       => t[i-1][8]  ,
    :m       => t[i-1][9]  ,
    :mag     => t[i-1][10]  ,
    :ip      => t[i-1][11]
  })
  i += 1
end

#Start Wounds

t = [
      [ 11 , 12 , 13 , 14 ] ,
      [  9 , 10 , 11 , 12 ] ,
      [  8 ,  9 , 10 , 11 ] ,
      [ 10 , 11 , 12 , 13 ]
    ]
i = 1
t.each do |w|
  StartingWound.create ( {
            :race_id => i,
            :d1_3 => t[i-1][0],
            :d4_6 => t[i-1][1],
            :d7_9 => t[i-1][2],
            :d10  => t[i-1][3],
  } )
  i += 1
end

#Start faith points
t = [
      [ 1 , 2 , 3 ] ,
      [ 1 , 2 , 2 ] ,
      [ 2 , 2 , 3 ] ,
      [ 2 , 3 , 3 ]
    ]
i = 1
t.each do |w|
  StartingFatePoint.create ( {
            :race_id => i,
            :d1_4 => t[i-1][0],
            :d5_7 => t[i-1][1],
            :d8_10=> t[i-1][2],
  } )

  i+=1
end

#Nain
rac = Race.find(1)
comp = Competence.find_by_name("Connaissances générales (Nains)")
rac.add_native_skill([comp])
comp = Competence.find_by_name("Langue (Khazalid)")
rac.add_native_skill([comp])
comp = Competence.find_by_name("Langue (Reikspiel)")
rac.add_native_skill([comp])
comp1 = Competence.find_by_name("Métier (Mineur)")
comp2 = Competence.find_by_name("Métier (Forgeron)")
comp3 = Competence.find_by_name("Métier (Maçon)")
rac.add_native_skill([comp1,comp2,comp3])

tal = Talent.find_by_name("Savoir-faire nain")
rac.add_native_talent([tal])
tal = Talent.find_by_name("Fureur vengeresse")
rac.add_native_talent([tal])
tal = Talent.find_by_name("Vision nocturne")
rac.add_native_talent([tal])
tal = Talent.find_by_name("Résistance à la magie")
rac.add_native_talent([tal])
tal = Talent.find_by_name("Valeureux")
rac.add_native_talent([tal])
tal = Talent.find_by_name("Robuste")
rac.add_native_talent([tal])

rac.save


#Elfe
rac = Race.find(2)
comp = Competence.find_by_name("Connaissances générales (Elfes)")
rac.add_native_skill([comp])
comp = Competence.find_by_name("Langue (Eltharin)")
rac.add_native_skill([comp])
comp = Competence.find_by_name("Langue (Reikspiel)")
rac.add_native_skill([comp])

tal = Talent.find_by_name("Acuité visuelle")
rac.add_native_talent([tal])
tal = Talent.find_by_name("Vision nocturne")
rac.add_native_talent([tal])
tal1 = Talent.find_by_name("Harmonie aethyrique")
tal2 = Talent.find_by_name("Maîtrise (Arcs long)")
rac.add_native_talent([tal1,tal2])
tal1 = Talent.find_by_name("Sang-froid")
tal2 = Talent.find_by_name("Intelligent")
rac.add_native_talent([tal1,tal2])


rac.save


#Halfing
rac = Race.find(3)
comp = Competence.find_by_name("Connaissances Académiques (GénéalogieHéraldique)")
rac.add_native_skill([comp])
comp = Competence.find_by_name("Connaissances générales (Halflings)")
rac.add_native_skill([comp])
comp = Competence.find_by_name("Langue (Halfling)")
rac.add_native_skill([comp])
comp = Competence.find_by_name("Langue (Reikspiel)")
rac.add_native_skill([comp])
comp1 = Competence.find_by_name("Métier (Cuisinier)")
comp2 = Competence.find_by_name("Métier (Fermier)")
rac.add_native_skill([comp1,comp2])
comp = Competence.find_by_name("Commérage")
rac.add_native_skill([comp])

tal = Talent.find_by_name("Maîtrise (Lance-pierres)")
rac.add_native_talent([tal])
tal = Talent.find_by_name("Vision nocturne")
rac.add_native_talent([tal])
tal = Talent.find_by_name("Résistance au chaos")
rac.add_native_talent([tal])
rac.add_random_talent

rac.save

#Humain
rac = Race.find(4)
comp = Competence.find_by_name("Connaissances générales (Empire)")
rac.add_native_skill([comp])
comp = Competence.find_by_name("Langue (Reikspiel)")
rac.add_native_skill([comp])
comp = Competence.find_by_name("Commérage")
rac.add_native_skill([comp])

rac.add_random_talent
rac.add_random_talent

rac.save
