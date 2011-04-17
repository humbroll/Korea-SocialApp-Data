# Scaffolding generated by Casein v.3.1.7

module Casein
  class RanksController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::Users access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @casein_page_title = 'Ranks'
  		@ranks = Rank.paginate :page => params[:page]
    end
  
    def show
      @casein_page_title = 'View rank'
      @rank = Rank.find params[:id]
    end
 
    def new
      @casein_page_title = 'Add a new rank'
    	@rank = Rank.new
    end

    def create
      @rank = Rank.new params[:rank]
    
      if @rank.save
        flash[:notice] = 'Rank created'
        redirect_to casein_ranks_path
      else
        flash.now[:warning] = 'There were problems when trying to create a new rank'
        render :action => :new
      end
    end
  
    def update
      @casein_page_title = 'Update rank'
      
      @rank = Rank.find params[:id]
    
      if @rank.update_attributes params[:rank]
        flash[:notice] = 'Rank has been updated'
        redirect_to casein_ranks_path
      else
        flash.now[:warning] = 'There were problems when trying to update this rank'
        render :action => :show
      end
    end
 
    def destroy
      @rank = Rank.find params[:id]

      @rank.destroy
      flash[:notice] = 'Rank has been deleted'
      redirect_to casein_ranks_path
    end
  
  end
end