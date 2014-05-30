# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
fyif = Album.find_by_name('The Gospelite - Four Years in the Future')
unless fyif
  a = Album.new(:name => "The Goseplite - Four Years in the future", :album_number => 1, :mp3_size => 50, :m4a_size => 0)
  a.save
  Track.create(:name => 'urnotalone', :local_name => 'urnotalone', :album => a, :download_count => 0, :track_number => 1)
  Track.create(:name => 'alright', :local_name => 'alright', :album => a, :track_number => 2)
  Track.create(:name => 'goodbye', :local_name => 'goodbye', :album => a, :track_number => 3)
  Track.create(:name => 'staggerdrop', :local_name => 'staggerdrop', :album => a, :track_number => 4)
  Track.create(:name => 'Short Bridge', :local_name => 'short_bridge', :album => a, :track_number => 5)
  Track.create(:name => 'holdinallurair', :local_name => 'hold_in_all', :album => a, :track_number => 6)
  Track.create(:name => 'einstein', :local_name => 'einstein', :album => a, :track_number => 7)
  Track.create(:name => 'moonlight sunrise', :local_name => 'moonlight_sunrise', :album => a, :track_number => 8)
  Track.create(:name => 'how to beg', :local_name => 'how_to_beg', :album => a, :track_number => 9)
  Track.create(:name => 'dogmorning', :local_name => 'dogmorning', :album => a, :track_number => 10)
  Track.create(:name => 'mistakes', :local_name => 'mistakes', :album => a, :track_number => 11)
  Track.create(:name => 'cherrypicker', :local_name => 'cherrypicker', :album => a, :track_number => 12)
  Track.create(:name => 'moms', :local_name => 'moms', :album => a, :track_number => 13)
end
