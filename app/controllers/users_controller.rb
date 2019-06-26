class UsersController < ApplicationController

  before_action :authenticate_user!

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    users = User.all
    authorize User
    # authorize current_user, User  # invokes pundit policy

    render 'index', locals: {users: users, current_user: current_user}
  end

  def show
    user = User.find params[:id]
    render 'show', locals: {user: user, current_user: current_user}
  end

  def destroy
    user = User.find params[:id]
    user.destroy
    redirect_to users_path, notice: 'user deleted'
  end

  private

  def user_not_authorized
    flash[:alert] = 'Access Denied'
    redirect_to (request.referrer || root_path)
  end

end
