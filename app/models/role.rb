class Role < ActiveRecord::Base
has_and_belongs_to_many :movies,
                        :join_table => "movies_artists_roles"

# def role_ids(role_names)
#    find(:all, :condition => ["role_
# end

end
