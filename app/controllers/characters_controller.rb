class CharactersController < ApplicationController

require 'dice'

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
    @career = Career.where("access like ?", "Basic%")
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

    #Put directly skill and talent in array instead of there link
    if ( @character.status == 0 )
      @nskl_choice = []
      tmp = @character.race.native_skills_array
      tmp.each do |skl_c|
        if skl_c.length > 1
          arr = skl_c.map { |x| x.competence }
          @nskl_choice << arr
        end
      end
      @ntal_choice = []
      tmp = @character.race.native_talents_array
      tmp.each do |tal_c|
        if tal_c.length > 1
          arr = tal_c.map { |x| x.talent }
          @ntal_choice << arr
        end
      end
    end
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
    ban_params
    @character = Character.new(params[:character])
    @character.user_id = current_user.id
    @character.status = 0
    respond_to do |format|
      if @character.save
        format.html { redirect_to edit_character_path(@character), notice: 'Character successuly created.' }
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
    if ( @character.status == 0 )
      if params[:native_comp]
        add_native_comp
      end
      if params[:native_tal]
        add_native_tal
      end
      if params[:shallya]
        @character.shallya_mercy(params[:shallya].to_sym)
      end
    end
    ban_params
    respond_to do |format|
      if spend_xp and @character.update_attributes(params[:character])
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

  private

  def ban_params
    #List of key to exclude from params
    ban_keys = [
      :base_weapon_skill, :base_balistic_skill, :base_strength,
      :base_toughness, :base_agility, :base_intelligence, :base_will_power,
      :base_fellowship,  :base_attacks, :base_wounds, :base_mouvement,
      :base_insanity_points, :base_fate_points, :base_magic,
      :status,
      :experience, :total_experience
    ]
    if params[:character]
      params[:character].except!(*ban_keys)
    end
  end

  def add_native_comp
   params[:native_comp].each do |c|
      comp = Competence.find( c[:competence_id] )
      @character.add_competence(comp)
    end
    @character.status = 1
  end

  def add_native_tal
    #Have to protect from cheat
   params[:native_tal].each do |c|
      tal = Talent.find( c[:talent_id] )
      @character.talents << tal
    end
    @character.status = 1
  end


end
