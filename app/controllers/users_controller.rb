class UsersController < ApplicationController

  before_action :require_login, :except => [:new, :show, :create]
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
      flash[:success] = "User  was created successfully!"

      sign_in(@user)
      redirect_to user_path(@user)
    else
      if !signed_in_user?
         flash[:error] = "User was NOT created successfully!"
         render :new
      else
        flash[:error] = "User was NOT created successfully!"
         redirect_to root_url
      end   
    end

  end

  def update
    if current_user.update(user_params)
        flash[:success] = "User was updated successfully!"
        redirect_to user_path(current_user)
    else    
      flash[:error] = "User NOT was updated successfully!"
      render :edit
    end
  end

  def destroy
    if current_user.destroy
      flash[:success] = "#{current_user.first_name} #{current_user.last_name} was removed!"
       redirect_to root_url
    else    
      flash[:alert] = "#{current_user.first_name} #{current_user.last_name} could not be removed!"
      redirect_to root_url
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
