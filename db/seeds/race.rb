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


rac.save

#Humain
rac = Race.find(4)
comp = Competence.find_by_name("Connaissances générales (Empire)")
rac.add_native_skill([comp])
comp = Competence.find_by_name("Langue (Reikspiel)")
rac.add_native_skill([comp])
comp = Competence.find_by_name("Commérage")
rac.add_native_skill([comp])
rac.save
