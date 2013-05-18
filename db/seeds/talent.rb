 
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
