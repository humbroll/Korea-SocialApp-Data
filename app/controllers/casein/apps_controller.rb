# Scaffolding generated by Casein v.3.1.7

module Casein
  class AppsController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @casein_page_title = 'Apps'
  		@apps = App.paginate :page => params[:page]
    end
  
    def show
      @casein_page_title = 'View app'
      @app = App.find params[:id]
    end
 
    def new
      @casein_page_title = 'Add a new app'
    	@app = App.new
    end

    def create
      @app = App.new params[:app]
    
      if @app.save
        flash[:notice] = 'App created'
        redirect_to casein_apps_path
      else
        flash.now[:warning] = 'There were problems when trying to create a new app'
        render :action => :new
      end
    end
  
    def update
      @casein_page_title = 'Update app'
      
      @app = App.find params[:id]
    
      if @app.update_attributes params[:app]
        flash[:notice] = 'App has been updated'
        redirect_to casein_apps_path
      else
        flash.now[:warning] = 'There were problems when trying to update this app'
        render :action => :show
      end
    end
 
    def destroy
      @app = App.find params[:id]

      @app.destroy
      flash[:notice] = 'App has been deleted'
      redirect_to casein_apps_path
    end
  
  end
end