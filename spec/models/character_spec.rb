require 'spec_helper'

describe Character do
#  pending "add some examples to (or delete) #{__FILE__}"

  before (:each) do
    @character = FactoryGirl.create(:character)
  end

  describe "Get charcter competence bonus" do 
    it "get the bonus of a character competence" do
      comp = FactoryGirl.create(:competence)
      #@character.competences << comp
      #@character.character_competences.first.bonus = 10
      @character.add_competence(comp)
      @character.add_competence(comp)
      @character.get_competence_bonus(comp).should == 10
    end
  end

  describe "Add a competence" do
    it "add a competence to a character" do
      @comp = FactoryGirl.create(:competence)
      #First add the comp as not already taken
      @character.add_competence(@comp)
      @character.competences.first.should == @comp && 
	@character.character_competences.count.should == 1
      #Add the comp a second time increase bonus to 10
      @character.add_competence(@comp)
      @character.character_competences.first.bonus.should == 10 && 
	@character.character_competences.count.should == 1
      #Add the comp a second time increase bonus to 20
      @character.add_competence(@comp)
      @character.character_competences.first.bonus.should == 20 && 
	@character.character_competences.count.should == 1
      #Add the comp a third time dont change bonus
      @character.add_competence(@comp)
      @character.character_competences.first.bonus.should == 20 && 
	@character.character_competences.count.should == 1
    end
  end


end
