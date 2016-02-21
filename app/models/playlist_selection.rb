class PlaylistSelection < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :song
  
  validates :song, :playlist, presence: true
end
