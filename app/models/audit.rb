class Audit < Version
set_table_name :audits
has_paper_trail :meta => { :audit_item_type  => Proc.new { | audit | audit.item_type },
				 	       :audit_item_id  => Proc.new { | audit | audit.item_id },
				 	       :item_type => Proc.new { | audit | audit.class.name },
					     }

	def self.records (item_id)
	   Version.find(:all, :conditions => ['item_type = ? and item_id = ?', "Audit" , item_id] )  
	end

end

