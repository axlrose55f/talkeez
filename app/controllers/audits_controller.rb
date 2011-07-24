class AuditsController < ApplicationController
filter_resource_access

  def approve
  	@audit = Audit.find(params[:id])
    if @audit != nil 
	  	audit_type = @audit.item_type
	  	object = audit_type.constantize.find(@audit.item_id)
	  	if object.approve_operation
           flash[:notice] = "Operation on #{audit_type} was successfully!"  
   		end    
     redirect_to(audits_user_path(current_user))     
	end  	
  end
  
  def show
   @audit = Audit.find(params[:id])
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