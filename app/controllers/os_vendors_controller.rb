class OsVendorsController < ApplicationController
  # GET /os_vendors
  # GET /os_vendors.json
  def index
    @os_vendors = OsVendor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @os_vendors }
    end
  end

  # GET /os_vendors/1
  # GET /os_vendors/1.json
  def show
    @os_vendor = OsVendor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @os_vendor }
    end
  end

  # GET /os_vendors/new
  # GET /os_vendors/new.json
  def new
    @os_vendor = OsVendor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @os_vendor }
    end
  end

  # GET /os_vendors/1/edit
  def edit
    @os_vendor = OsVendor.find(params[:id])
  end

  # POST /os_vendors
  # POST /os_vendors.json
  def create
    @os_vendor = OsVendor.new(params[:os_vendor])

    respond_to do |format|
      if @os_vendor.save
        format.html { redirect_to @os_vendor, notice: 'Os vendor was successfully created.' }
        format.json { render json: @os_vendor, status: :created, location: @os_vendor }
      else
        format.html { render action: "new" }
        format.json { render json: @os_vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /os_vendors/1
  # PUT /os_vendors/1.json
  def update
    @os_vendor = OsVendor.find(params[:id])

    respond_to do |format|
      if @os_vendor.update_attributes(params[:os_vendor])
        format.html { redirect_to @os_vendor, notice: 'Os vendor was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @os_vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /os_vendors/1
  # DELETE /os_vendors/1.json
  def destroy
    @os_vendor = OsVendor.find(params[:id])
    @os_vendor.destroy

    respond_to do |format|
      format.html { redirect_to os_vendors_url }
      format.json { head :ok }
    end
  end
end
