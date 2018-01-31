class RatingPolicy < ApplicationPolicy
  def create?
    user.present?
  end 
end