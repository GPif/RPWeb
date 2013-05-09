class CharactersController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]

  # GET /characters
  # GET /characters.json
  def index
    @characters = Character.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @characters }
    end
  end

  # GET /characters/1
  # GET /characters/1.json
  def show
    @character = Character.find(params[:id])
    @char_comp = @character.character_competences
    @competences = Competence.where(:base => true)
    @chara_adv_comp = @char_comp.select { |x| ! x.competence.base }

    @char_talents = @character.talents

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @character }
    end
  end

  # GET /characters/new
  # GET /characters/new.json
  def new
    @race = Race.all
    @career = Career.all
    @character = Character.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @character }
    end
  end

  # GET /characters/1/edit
  def edit
    @race = Race.all
    @character = Character.find(params[:id])
    @char_comp = @character.character_competences
    @competences = Competence.where(:base => true)
    @chara_adv_comp = @char_comp.select { |x| ! x.competence.base }
    @career = Career.all

    @char_talents = @character.talents
  end

  # POST /characters/1/add_talent
  def add_talent
    @character = Character.find(params[:id])
    talent=Talent.find(params[:talent][:talent_id])
    respond_to do |format|
      if @character.talents << talent
	format.html { redirect_to edit_character_path(@character), notice: 'Talent successfully added.' }
        format.json { render json: @character, status: :created, location: @character }
      else
        format.html { render action: "new" }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def rm_talent
    @character = Character.find(params[:id])
    talent = Talent.find(params[:talent_id])
    respond_to do |format|
      if @character.talents.delete(talent)
	format.html { redirect_to edit_character_path(@character), notice: 'Talent successfully removed.' }
        format.json { render json: @character, status: :created, location: @character }
      else
        format.html { render action: "new" }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # POST /characters
  # POST /characters.json
  def create
    @character = Character.new(params[:character])
    @character.user_id = current_user.id

    respond_to do |format|
      if @character.save
        format.html { redirect_to @character, notice: 'Talent successfully added.' }
        format.json { render json: @character, status: :created, location: @character }
      else
        format.html { render action: "new" }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /characters/1
  # PUT /characters/1.json
  def update
    @character = Character.find(params[:id])

    respond_to do |format|
      if @character.update_attributes(params[:character])
        format.html { redirect_to @character, notice: 'Character was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /characters/1
  # DELETE /characters/1.json
  def destroy
    @character = Character.find(params[:id])
    @character.destroy

    respond_to do |format|
      format.html { redirect_to characters_url }
      format.json { head :no_content }
    end
  end
end
