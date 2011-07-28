class AuditsController < ApplicationController
filter_resource_access

  def approve
  	@audit = Audit.find(params[:id])
    if @audit != nil 
	  	audit_type = @audit.item_type
	  	if @audit.event == "create"
		  	object = audit_type.constantize.pending(@audit.item_id).first
		else
		    object = audit_type.constantize.find(@audit.item_id)
		end
	  	if object.approve_operation
           flash[:notice] = "Operation on #{audit_type} was successfully!"  
   		end    
     redirect_to(audits_user_path(current_user))     
	end  	
  end
  
#   def approve_create
#     @audit = Audit.find(params[:id])
#     if !@audit.nil? && @audit.event == "create"
#       audit_type = @audit.item_type
# 	  object = audit_type.constantize.pending(@audit.item_id)
# 	  if object.approve_operation
#            flash[:notice] = "Create Operation on #{audit_type} was approved successfully!"  
#    	  end    
#      redirect_to(audits_user_path(current_user)) 	  
#     end
#   end
  
  def show
   @audit = Audit.find(params[:id])
  end
  
    
  def versions
     @versions = Audit.records(params[:id])
  end
  
  def revert
    @version = Version.find(params[:version_id])
    if @version.reify
       @version.reify.save!
    end
    redirect_to(audits_user_path(current_user))     
  end
  
  def reject
    @audit = Audit.find(params[:id])
    if @audit != nil 
	  	audit_type = @audit.item_type
	  	object = audit_type.constantize.find(@audit.item_id)
	  	if object.reject_operation
           flash[:notice] = "Operation on #{audit_type} was reverted succesfully!"  
   		end    
     redirect_to(audits_user_path(current_user))     
	end  	
  end
  
  def destroy
    @record = Audit.find(params[:id])
    @record.destroy

     respond_to do |format|
       format.html { redirect_to(audits_user_path(current_user)) }
       format.xml  { head :ok }
     end
  end
end