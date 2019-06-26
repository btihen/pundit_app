class UserPolicy < ApplicationPolicy
  # attr_reader :current_user, :model

  # def initialize(user = current_user, model)
  #   @current_user  = current_user
  #   @model = model
  # end

  def index?
    @user.admin?
  end

  def show?
    # user is either admin or user is getting own record
    @user.admin? || @user.id == @record.id
  end

end
