class UsersController < ApplicationController

  before_action :authenticate_user!

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    # users = User.all
    # authorize User
    users = UserPolicy::UserIndexScope.new(current_user, User).resolve

    render 'index', locals: {users: users, current_user: current_user}
  end

  def show
    user = User.find params[:id]
    authorize user

    render 'show', locals: {user: user, current_user: current_user}
  end

  def edit
    user = User.find params[:id]
    authorize user

    render 'edit', locals: {user: user, current_user: current_user}
  end

  def update
    user = User.find params[:id]
    authorize user

    user.update(user_params)
    if user.save
      render 'show', locals: {user: user, current_user: current_user}
    else
      flash[:alert] = "Opps, there was a problem"
      render 'edit', locals: {user: user, current_user: current_user}
    end
  end

  def destroy
    user = User.find params[:id]
    authorize user

    user.destroy
    redirect_to users_path, notice: 'user deleted'
  end

  private

  def user_not_authorized
    flash[:alert] = 'Access Denied'
    redirect_to (request.referrer || root_path)
  end

  def user_params
    params.require(:user).permit(:role)
  end

end
