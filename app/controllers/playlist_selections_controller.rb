
class PlaylistSelectionsController < ApplicationController

  before_action :require_current_user

  def create

    @playlist_selection = PlaylistSelection.new(playlist_selection_params)

    if @playlist_selection.save
      flash[:success] = "Song was added to playlist successfully!"
      redirect_to root_path
    else
      if !signed_in_user?
         flash[:error] = "Playlist was NOT created successfully!"
         render :new
      else
        flash[:error] = "Playlist was NOT created successfully!"
        redirect_to root_url
      end   
    end

  end

  def destroy
    
    @playlist_selection = PlaylistSelection.find_by_id(params[:id])

    if !@playlist_selection
      flash[:error] = "No such playlist to remove!"
      redirect_to root_url

    elsif @playlist_selection.destroy
      
      flash[:success] = "Playlist Selection was removed!"
      redirect_to root_url
    else    
      
      flash[:alert] = "Playlist Selection could not be removed!"
      redirect_to root_url
    end
  end

  private

  def playlist_selection_params

     params.require(:playlist_selection).permit(
          :playlist_id,
          :song_id
      )

  end

  def redirect_to_referer
    if params[:artist_id] 
      redirect_to artist_path(params[:artist_id])
    elsif params[:song_id] 
      redirect_to song_path(params[:song_id])
    else
      redirect_to playlist_path(params[:playlist_id])
    end
  end  

end