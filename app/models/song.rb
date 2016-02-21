class Song < ActiveRecord::Base
    belongs_to :artist
    has_many   :playlist_selections,  dependent:   :destroy
    has_many   :playlists, through: :playlist_selections
    has_many :bookmarks, -> { order('created_at ASC') }, as: :bookmarkable, dependent:   :destroy

    validates :name, :artist, presence: true
end
