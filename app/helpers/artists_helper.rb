module ArtistsHelper

  def bookmarked_artist(user,artist)
    if artist.bookmarks.where("user_id = ?", user.id).empty?
      return false 
    end
    return artist.bookmarks.where("user_id = ?", user.id)[0]
  end

end
