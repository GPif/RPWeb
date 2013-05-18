class Race < ActiveRecord::Base
  has_many :native_skills
  has_many :native_talents
  has_many :competences, :through => :native_skills
  attr_accessible :name
  
  NATIVE_FEATURES = [
          {:name => 'skill',:class => 'Competence'} , 
          {:name => 'talent',:class => 'Talent'}
        ]

  NATIVE_FEATURES.each do |f|
    class_name   = 'Native'+f[:name].capitalize
    class_access = 'native_'+f[:name].downcase.pluralize
    access       = f[:class].downcase

     define_method "add_native_#{f[:name]}" do |arr|
      #CHoice order
      i = 0
      #Find existing requirement id for this race
      eval ("rid = #{class_name}.maximum('requirement_id', " + 
                 ":conditions => ['race_id = ?',self.id]).to_i" )
      #and create the new id
      rid += 1
      arr.each do |elt|
        ns = eval"#{class_name}.new"
        eval "ns.#{access} = elt"
        ns.choice_ord = i
        ns.requirement_id = rid
        i += 1
        eval" self.#{class_access} << ns"
      end
    end

    define_method "native_#{f[:name].pluralize}_array" do
      h = {}
      arr_features = eval "self.#{class_access}"
      arr_features.each do |ns|
        h[ns.requirement_id.to_s] ||= []
        eval "h[ns.requirement_id.to_s] << ns.#{access}"
      end
      return h.values
    end

  end

end
 
