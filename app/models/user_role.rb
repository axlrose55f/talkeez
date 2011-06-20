class UserRole < ActiveRecord::Base
 self.table_name = "user_roles"
 belongs_to :user
 belongs_to :role,
			:class_name => "UserRoleTypes",
 			:foreign_key => "user_role_type_id"
end