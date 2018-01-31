class PostPolicy < ApplicationPolicy
  def new?
    user.present?
  end  

  def create?
    user.present?
  end 

  def edit?
    record.user_id == user.id
  end  
    
  def update?
    record.user_id == user.id
  end

  def destroy?
    record.user_id == user.id
  end
end