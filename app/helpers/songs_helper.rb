module SongsHelper
  def bookmarked_song(user,song)
    if song.bookmarks.where("user_id = ?", user.id).empty?
      return false 
    end
    return song.bookmarks.where("user_id = ?", user.id)[0]
  end
end
