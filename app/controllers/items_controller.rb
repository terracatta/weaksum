class ItemsController < ApplicationController
  
  def find
    hash_type = params[:hash_type].to_sym
    
    unless hash_type.blank?
      case hash_type
      when :fuzzy_hash
        limits = params[:tolerance].gsub('%','').split(' - ').map(&:to_i)
        @items = Item.find_fuzzy_matches(params[:hash],limits.first, limits.last)
      else
        @item = Item.find_by_hash(params[:hash], hash_type)
      end
    else
      @item = Item.find_by_hash(params[:hash]) 
    end
    
    respond_to do |format|
      format.html { redirect_to @item } if @item
      format.html { render :index } if @items
      format.json { render json: @item }
    end
  end
  
  def find_fuzzy_matches
    tolerance = params[:tolerance]
    hash = params[:hash]
    
    if tolerance
      @item_matches = Item.find_fuzzy_matches(hash, tolerance)
    else
      @item_matches = Item.find_fuzzy_matches(hash)
    end
    
    respond_to  do |format|
      format.html { render :fuzzy_matches }
      format.json { render json: @item_matches }
    end
    
  end

  
  def compare
    @item1 = Item.find(params[:item1_id])
    @item2 = Item.find(params[:item2_id])
    @percent_match = Ssdeep.fuzzy_compare(@item1.fuzzy_hash, @item2.fuzzy_hash)
  end
  
  # GET /items
  # GET /items.json
  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new

    respond_to do |format|
      format.html { render :new, :layout => false } # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :ok }
    end
  end
end
