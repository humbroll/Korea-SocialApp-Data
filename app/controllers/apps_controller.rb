class AppsController < ApplicationController
  # GET /apps
  # GET /apps.xml
  def index
    @graphData = []
    ranks = Rank.find(:all, 
      :limit=>10, 
      :order => "rank ASC", 
      :conditions=>["orderType=? and created_at > ?", 1, 1.days.ago])
      
    ranks.each do |r|
      obj =  {
        :label=>r.app.name,
        :data=>[]
      }
      r.app.ranks.each do |r|
        #obj[:data] << [r.created_at.localtime.to_time.to_i*1000, r.downloadCount]
        obj[:data] << [r.created_at.localtime.to_time.to_i*1000, r.rank]
      end
      @graphData << obj
    end

    @graphOptions = {
      :series => {
          :lines => { :show => true },
          :points => { :show => true }
      },
      :legend => { :noColumns => 3},
      :xaxis => {
        :mode => "time",
        :tickSize => [1, "day"],
        :timeformat => "%y/%m/%d"
      },
      :selection => { :mode => "x" }
    }
    
    # var options = {
    #     series: {
    #         lines: { show: true },
    #         points: { show: true }
    #     },
    #     legend: { noColumns: 2 },
    #     xaxis: { tickDecimals: 0 },
    #     yaxis: { min: 0 },
    #     selection: { mode: "x" }
    # };
    # 
    
    
    @apps = App.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @apps }
    end
  end
  
  # def graphAll
  # 
  # end
  
  # GET /apps/1
  # GET /apps/1.xml
  def show
    @app = App.find(params[:id])
    
    @rankData = []
    orderType = (@app.platform == "nate")? "1" : "INSTALL"

    @app.ranks.find(:all, :conditions=>{:orderType=>orderType}).each do |r|
      @rankData << [r.created_at.localtime.to_time.to_i*1000, r.downloadCount]
    end
    
    @graphOptions = {
      "xaxis"=>{
        :mode => "time",
        :tickSize => [1, "day"],
        :timeformat => "%y/%m/%d"
      }
    }

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @app }
    end
  end

  # GET /apps/new
  # GET /apps/new.xml
  def new
    @app = App.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @app }
    end
  end

  # GET /apps/1/edit
  def edit
    @app = App.find(params[:id])
  end

  # POST /apps
  # POST /apps.xml
  def create
    @app = App.new(params[:app])

    respond_to do |format|
      if @app.save
        format.html { redirect_to(@app, :notice => 'App was successfully created.') }
        format.xml  { render :xml => @app, :status => :created, :location => @app }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @app.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /apps/1
  # PUT /apps/1.xml
  def update
    @app = App.find(params[:id])

    respond_to do |format|
      if @app.update_attributes(params[:app])
        format.html { redirect_to(@app, :notice => 'App was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @app.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /apps/1
  # DELETE /apps/1.xml
  def destroy
    @app = App.find(params[:id])
    @app.destroy

    respond_to do |format|
      format.html { redirect_to(apps_url) }
      format.xml  { head :ok }
    end
  end
end
