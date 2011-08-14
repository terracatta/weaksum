class OperatingSystemsController < ApplicationController
  # GET /operating_systems
  # GET /operating_systems.json
  def index
    @operating_systems = OperatingSystem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @operating_systems }
    end
  end

  # GET /operating_systems/1
  # GET /operating_systems/1.json
  def show
    @operating_system = OperatingSystem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @operating_system }
    end
  end

  # GET /operating_systems/new
  # GET /operating_systems/new.json
  def new
    @operating_system = OperatingSystem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @operating_system }
    end
  end

  # GET /operating_systems/1/edit
  def edit
    @operating_system = OperatingSystem.find(params[:id])
  end

  # POST /operating_systems
  # POST /operating_systems.json
  def create
    @operating_system = OperatingSystem.new(params[:operating_system])

    respond_to do |format|
      if @operating_system.save
        format.html { redirect_to @operating_system, notice: 'Operating system was successfully created.' }
        format.json { render json: @operating_system, status: :created, location: @operating_system }
      else
        format.html { render action: "new" }
        format.json { render json: @operating_system.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /operating_systems/1
  # PUT /operating_systems/1.json
  def update
    @operating_system = OperatingSystem.find(params[:id])

    respond_to do |format|
      if @operating_system.update_attributes(params[:operating_system])
        format.html { redirect_to @operating_system, notice: 'Operating system was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @operating_system.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operating_systems/1
  # DELETE /operating_systems/1.json
  def destroy
    @operating_system = OperatingSystem.find(params[:id])
    @operating_system.destroy

    respond_to do |format|
      format.html { redirect_to operating_systems_url }
      format.json { head :ok }
    end
  end
end
