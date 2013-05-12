require 'yaml'

File.open('Compendium.yaml') do |yf|
  YAML.load_documents( yf ) do |ydoc|
    ydoc.each { |x| puts x[:name] }
  end 
end
