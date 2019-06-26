class UsersController < ApplicationController

  def index
    users = User.all
    render 'index', locals: {users: users, current_user: current_user}
  end

  def show
    user = User.find param[:id]
    render 'show', locals: {user: user, current_user: current_user}
  end

  def destroy
    user = User.find param[:id]
    user.destroy
    redirect_to users_path, notice: 'user deleted'
  end

end
