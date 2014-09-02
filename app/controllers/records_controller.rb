class RecordsController < ApplicationController
  before_action :set_record, only: [:show, :edit, :update, :destroy]

  # GET /records
  # GET /records.json
  def index
    @records = Record.all
  end

  # GET /records/1
  # GET /records/1.json
  def show
  end

  # GET /records/new
  def new
    @emu_person = EmuPerson.find params[:emu_person_id]
    @record = Record.new(emu_person: @emu_person)
  end

  # GET /records/1/edit
  def edit
  end

  # POST /emu_person/:emu_person_id/records/:record_id
  def create
    @emu_person = EmuPerson.find params[:emu_person_id]
    @emu_person.records.build(record_params)

    respond_to do |format|
      if @emu_person.save
        format.html { redirect_to @emu_person, notice: 'Record was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /records/1
  # PATCH/PUT /records/1.json
  def update
    @record = Record.find params[:id]

    puts "====================== update"
    # http://temp-sample-data.herokuapp.com/objects/nmnhbotany_2576760.json
    # {"edan_id":"nmnhbotany_2576760","thumbnail":"http://collections.nmnh.si.edu/search/botany/search.php?irn=10334544\u0026action=11\u0026qtab=0\u0026thumb=yes","title":"Vanilla pompona Schiede"}
    require 'httpclient'
    http = HTTPClient.new
    response  = http.get("#{Record::SOURCE_URL}#{record_params[:edan_id]}.json")
    result = JSON.parse(response.content)
    puts result['thumbnail']
    puts result['title']
    puts result.inspect
    new_params = record_params
    new_params['image_uri'] = result['thumbnail']
    new_params['description'] = result['title']
    puts "== new_params =="
    puts new_params.inspect
    respond_to do |format|
      if @record.update(new_params)
        format.html { redirect_to @record, notice: 'Record was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    @record.destroy
    respond_to do |format|
      format.html { redirect_to records_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = Record.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def record_params
      params.require(:record).permit(:edan_id, :image_uri, :description, :object_type)
    end
end
