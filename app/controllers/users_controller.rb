class UsersController < ApplicationController

  before_action :require_login, :except => [:new, :create]
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @playlists = @user.playlists
    @bookmarks = @user.bookmarks
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create

    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "User  was craeted successfully!"
      sign_in(@user)
      redirect_to edit_user_path(@user)
    else
      flash[:alert] = "User was NOT craeted successfully!"
      render :new
    end

  end

  def update
    if current_user.update(user_params)
        flash[:success] = "User was updated successfully!"
        redirect_to user_path(current_user)
    else    
      flash[:alert] = "User NOT was updated successfully!"
      render :edit
    end
  end

  def destroy
    if current_user.destroy
      flash[:success] = "#{current_user.first_name} #{current_user.last_name} was removed!"
      redirect_to user_path(current_user)
    else    
      flash[:alert] = "#{current_user.first_name} #{current_user.last_name} could not be removed!"
      render :edit
    end
  end

  private

    def user_params

      params.require(:user).permit(
        :first_name,
        :last_name,
        :email,
        :password,
        :id
      )
    end
end
