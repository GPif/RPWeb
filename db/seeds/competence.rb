##Competence
puts "Delete all"
Competence.delete_all

puts "Insert Competences"

doc = Document.new(File.new("db/competences.xml"))
root = doc.root
root.each_element('//competence') do |c|
  desc = c.elements['description'].text
  if (desc.gsub(/\n/,'').gsub(/Talents lies :.*/,'') =~ /Specialisation :(.*)/)
    $1.gsub(/\s/,'').split(/\,/).each do |spec|
      comp = Competence.new
      comp.name = c.elements['title'].text + " (#{spec})"
      comp.base = (c.elements['base'].text == "true")
      comp.description = c.elements['description'].text
      comp.characteristic = c.elements['cara'].text
      comp.save
      puts "Name : " << comp.name
    end
  else
    comp = Competence.new
    comp.name = c.elements['title'].text
    comp.base = (c.elements['base'].text == "true")
    comp.description = c.elements['description'].text
    comp.characteristic = c.elements['cara'].text
    comp.save
    puts "Name : " << comp.name
  end
end
