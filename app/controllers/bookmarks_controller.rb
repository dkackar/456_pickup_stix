class BookmarksController < ApplicationController
 
  before_action :require_current_user, :only => [:create, :destroy]

  def create

    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.user_id = current_user.id

    if @bookmark.save
      flash[:success] = "Bookmarked successfully!"
      redirect_to_referer
    else
      if !signed_in_user?
         flash[:error] = "Could not Bookmark!"
         render :new
      else
        flash[:error] = "Could not bookmark!"
         redirect_to root_url
      end   
    end

  end

  def destroy

    @bookmark = Bookmark.find_by_id(params[:id])

    if !@bookmark
      flash[:error] = "No such bookmark to un-bookmark!"  
      redirect_to root_url
    elsif @bookmark.destroy
      flash[:success] = "Un-Bookmarked successfully!"
      redirect_to login_path
    else
      if !signed_in_user?
        flash[:error] = "Could not UnBookmark!"
        render :new
      else
        flash[:error] = "Coudld not Unbookmark!"
        redirect_to root_url
      end
    end

  end

  private

  def bookmark_params

    return {bookmarkable_id: params[:bookmarkable_id],
            bookmarkable_type: params[:bookmarkable_type]}
  end

  def redirect_to_referer
    if params[:artist_id]
      redirect_to artist_path(params[:artist_id])
    elsif (params[:bookmarkable_type] == "Artist")
      redirect_to artist_path(params[:bookmarkable_id])
    elsif params[:bookmarkable_type] == "Song"
        redirect_to song_path(params[:bookmarkable_id])
    elsif params[:bookmarkable_type] == "Playlist"
      redirect_to playlist_path(params[:bookmarkable_id])
    end

  end
  
end