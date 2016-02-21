module PlaylistsHelper
  def bookmarked_playlist(user,playlist)
    if playlist.bookmarks.where("user_id = ?", user.id).empty?
      return false 
    end
    return playlist.bookmarks.where("user_id = ?", user.id)[0]
  end
end
