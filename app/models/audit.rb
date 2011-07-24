class Audit < Version
set_table_name :audits
has_paper_trail :meta => { :audit_item_type  => Proc.new { | audit | audit.item_type },
				 	       :audit_item_id  => Proc.new { | audit | audit.item_id }
					     }
end