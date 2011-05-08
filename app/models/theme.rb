class Theme < ActiveRecord::Base
has_and_belongs_to_many :movies,
                        :join_table => "movies_themes"
end
