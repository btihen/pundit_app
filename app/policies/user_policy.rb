class UserPolicy < ApplicationPolicy
  # attr_reader :current_user, :model

  # def initialize(user = current_user, model)
  #   @current_user  = current_user
  #   @model = model
  # end

  def index?
    @user.admin?
  end

end
