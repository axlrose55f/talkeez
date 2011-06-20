authorization do  
  role :guest do
    has_permission_on :users, :to => :create
  end
  
  role :user do
    includes :guest
    has_permission_on :users, :to => [:update,:show, :reviews, :videos, :movies,:artists, :friends] do
      if_attribute :id => is { user.id }
    end    
  end
  
  role :admin do
     has_omnipotence
    #includes :user
    #has_permission_on :users, :to => [:manage, :read, :update]
  end  
end

privileges do
  # default privilege hierarchies to facilitate RESTful Rails apps
  privilege :manage, :includes => [:create, :read, :update, :delete, :addRole ]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => [:edit, :update]
  privilege :delete, :includes => [:destroy, :deleteRole]
end
