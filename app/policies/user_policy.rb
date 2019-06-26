class UserPolicy < ApplicationPolicy

  def index?
    @user.admin?
  end

  def show?
    # user is either admin or user is getting own record
    @user.admin? || (@user.id == @record.id)
  end

  def edit?
    # user is admin but can't ones edit own record
    @user.admin? && (@user.id != @record.id)
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

end
