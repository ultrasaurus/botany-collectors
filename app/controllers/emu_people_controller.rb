class EmuPeopleController < ApplicationController
  before_action :set_emu_person, only: [:show, :edit, :update, :destroy]


  def frequency_data
    segment = params[:segment]
    render json: EmuPerson.frequency_data(segment)

  end

  def frequency_by_percent
    render json: EmuPerson.frequency_by_percent
  end


  # GET /emu_people
  # GET /emu_people.json
  def index
    @emu_people = EmuPerson.page(params[:page]).per(100)
  end

  # GET /emu_people/1
  # GET /emu_people/1.json
  def show
  end

  # GET /emu_people/new
  def new
    @emu_person = EmuPerson.new
  end

  # GET /emu_people/1/edit
  def edit
  end

  # POST /emu_people
  # POST /emu_people.json
  def create
    @emu_person = EmuPerson.new(emu_person_params)

    respond_to do |format|
      if @emu_person.save
        format.html { redirect_to @emu_person, notice: 'Emu person was successfully created.' }
        format.json { render action: 'show', status: :created, location: @emu_person }
      else
        format.html { render action: 'new' }
        format.json { render json: @emu_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emu_people/1
  # PATCH/PUT /emu_people/1.json
  def update
    respond_to do |format|
      if @emu_person.update(emu_person_params)
        format.html { redirect_to @emu_person, notice: 'Emu person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @emu_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emu_people/1
  # DELETE /emu_people/1.json
  def destroy
    @emu_person.destroy
    respond_to do |format|
      format.html { redirect_to emu_people_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_emu_person
      @emu_person = EmuPerson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def emu_person_params
      params.require(:emu_person).permit(:count, :irn, :full_name, :brief_name, :birth_date, :death_date, :bio_location, :start_date, :end_date)
    end
end
