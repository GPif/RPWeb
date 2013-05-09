class CharacterCompetencesController < ApplicationController

  def create
    @competence = Competence.find(params[:character_competence][:competence_id])
    add_comp(@competence)
    redirect_to edit_character_path(@character)
  end
  
  def destroy
    @char_comp = CharacterCompetence.find(params[:id])
    @char_comp.destroy

    respond_to do |format|
      format.html { redirect_to edit_character_path(@char_comp.character) }
      format.json { head :no_content }
    end
  end

  def add_comp(comp)
    @character = Character.find(params[:character_id])
    @char_comp = CharacterCompetence.find_by_character_id_and_competence_id(@character.id,comp.id)
    if @char_comp.blank?
      @char_comp = CharacterCompetence.create(:character_id => @character.id, :competence_id => comp.id,
                    :bonus => 0 )
    else
      if @char_comp.bonus < 20
        @char_comp.bonus += 10
        @char_comp.save
      end
    end

  end
end
