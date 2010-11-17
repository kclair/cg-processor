class RemoteAssetsController < ApplicationController
  # GET /remote_assets
  # GET /remote_assets.xml
  def index
    @remote_assets = RemoteAsset.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @remote_assets }
    end
  end

  # GET /remote_assets/1
  # GET /remote_assets/1.xml
  def show
    @remote_asset = RemoteAsset.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @remote_asset }
      format.json { render :json => @remote_asset }
    end
  end

  # GET /remote_assets/new
  # GET /remote_assets/new.xml
  def new
    @remote_asset = RemoteAsset.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @remote_asset }
      format.json { render :json => @remote_asset }
    end
  end

  # GET /remote_assets/1/edit
  def edit
    @remote_asset = RemoteAsset.find(params[:id])
  end

  # POST /remote_assets
  # POST /remote_assets.xml
  def create
    @asset = RemoteAsset.new(params[:remote_asset])

    respond_to do |format|
      if @asset.save
        format.html { redirect_to(@asset, :notice => 'Asset was successfully created.') }
        format.xml  { render :xml => @asset, :status => :created, :location => @asset }
        format.json { render :json => {:result => 1, :id => @asset.id}.to_json }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asset.errors, :status => :unprocessable_entity }
        format.json { render :json => {:result => 0, :errors => @asset.errors}.to_json }
      end
    end
  end


  # PUT /remote_assets/1
  # PUT /remote_assets/1.xml
  def update
    @remote_asset = RemoteAsset.find(params[:id])

    respond_to do |format|
      if @remote_asset.update_attributes(params[:remote_asset])
        format.html { redirect_to(@remote_asset, :notice => 'RemoteAsset was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @remote_asset.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /remote_assets/1
  # DELETE /remote_assets/1.xml
  def destroy
    @remote_asset = RemoteAsset.find(params[:id])
    @remote_asset.destroy

    respond_to do |format|
      format.html { redirect_to(remote_assets_url) }
      format.xml  { head :ok }
    end
  end
end
