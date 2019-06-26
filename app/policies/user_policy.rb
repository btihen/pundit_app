class UserPolicy < ApplicationPolicy

  def index?
    true
    # @user.admin?
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

  # if different users are allowed to submit different params
  # def permitted_attributes
  #   if user.admin? || user.owner_of?(post)
  #     [:title, :body, :tag_list]
  #   else
  #     [:tag_list]
  #   end
  # end
  # in the controller: user.update_attributes(permitted_attributes(user))

  class UserIndexScope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        # need an array
        scope.where(id: user.id)
      end
    end
  end

end
