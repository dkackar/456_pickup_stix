class PlaylistsController < ApplicationController

  before_action :require_current_user, :only => [:edit, :new, :create, :update, :destroy]

  def index
    @playlists = Playlist.all
  end

  def show
    @playlist = Playlist.find(params[:id])
  end

  def new
    @playlist = Playlist.new
  end

   def edit
    @playlist = Playlist.find(params[:id])
  end

  def create

    @playlist = Playlist.new(playlist_params)
    @playlist.user_id = current_user.id

    if @playlist.save
      flash[:success] = "Playlist was created successfully!"
      redirect_to playlist_path(@playlist)
    else
      if !signed_in_user?
        flash[:error] = "Playlist was NOT created successfully!"
        redirect_to root_url
      else
        flash[:error] = "Playlist was NOT created successfully!"
         render :new
      end   
    end

  end

  def update
    @playlist = Playlist.find_by_id(params[:id])
    if @playlist.update(playlist_params)
        flash[:success] = "Playlist was updated successfully!"
        redirect_to playlist_path(@playlist)
    else    
      flash[:error] = "Playlist NOT was updated successfully!"
      render :edit
    end
  end

  def destroy
    @playlist = Playlist.find_by_id(params[:id])

    if !@playlist
      flash[:error] = "Playlist was not found!"
      redirect_to root_url
    elsif @playlist.destroy
      flash[:success] = "Playlist was removed!"
      redirect_to user_path(current_user)
    else    
      flash[:alert] = "Playlist could not be removed!"
      redirect_to root_url
    end
  end

  private

    def playlist_params

      params.require(:playlist).permit(
        :name
      )
    end
end
