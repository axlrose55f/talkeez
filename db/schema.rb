# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090607012650) do

  create_table "albums", :force => true do |t|
    t.string  "name"
    t.text    "description"
    t.string  "image_url"
    t.date    "year"
    t.integer "movie_id"
    t.integer "music_director_id"
    t.integer "genre_id"
    t.integer "lyricist_id"
  end

  add_index "albums", ["genre_id"], :name => "fk_albums_genres"
  add_index "albums", ["lyricist_id"], :name => "fk_albums_lyricist"
  add_index "albums", ["movie_id"], :name => "fk_albums_movies"
  add_index "albums", ["music_director_id"], :name => "fk_albums_music_dir"

  create_table "albums_genres", :id => false, :force => true do |t|
    t.integer "album_id", :null => false
    t.integer "genre_id", :null => false
  end

  add_index "albums_genres", ["album_id", "genre_id"], :name => "index_albums_genres_on_album_id_and_genre_id"
  add_index "albums_genres", ["genre_id"], :name => "index_albums_genres_on_genre_id"

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.text     "biography"
    t.string   "image_url"
    t.date     "dob"
    t.string   "birth_place"
    t.string   "country"
    t.string   "birth_name"
    t.integer  "height"
    t.integer  "weight"
    t.string   "marital_status"
    t.string   "education"
    t.string   "star_sign"
    t.string   "religion"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "awards", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "genres", :force => true do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "moods", :force => true do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "movies", :force => true do |t|
    t.string   "name"
    t.string   "country"
    t.string   "language"
    t.string   "studio"
    t.string   "color"
    t.string   "certification"
    t.string   "image_url"
    t.text     "keywords"
    t.text     "description"
    t.string   "aspect_ratio"
    t.date     "year"
    t.integer  "run_time"
    t.integer  "rating"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "movies_artists_roles", :force => true do |t|
    t.integer "movie_id",  :null => false
    t.integer "artist_id", :null => false
    t.integer "role_id",   :null => false
  end

  add_index "movies_artists_roles", ["artist_id", "role_id"], :name => "index_movies_artists_roles_on_artist_id_and_role_id"
  add_index "movies_artists_roles", ["movie_id", "artist_id", "role_id"], :name => "index_movies_artists_roles_on_movie_id_and_artist_id_and_role_id"
  add_index "movies_artists_roles", ["role_id"], :name => "index_movies_artists_roles_on_role_id"

  create_table "movies_awards", :id => false, :force => true do |t|
    t.integer "movie_id", :null => false
    t.integer "award_id", :null => false
  end

  add_index "movies_awards", ["award_id"], :name => "index_movies_awards_on_award_id"
  add_index "movies_awards", ["movie_id", "award_id"], :name => "index_movies_awards_on_movie_id_and_award_id"

  create_table "movies_genres", :id => false, :force => true do |t|
    t.integer "movie_id", :null => false
    t.integer "genre_id", :null => false
  end

  add_index "movies_genres", ["genre_id"], :name => "index_movies_genres_on_genre_id"
  add_index "movies_genres", ["movie_id", "genre_id"], :name => "index_movies_genres_on_movie_id_and_genre_id"

  create_table "movies_themes", :id => false, :force => true do |t|
    t.integer "movie_id", :null => false
    t.integer "theme_id", :null => false
  end

  add_index "movies_themes", ["movie_id", "theme_id"], :name => "index_movies_themes_on_movie_id_and_theme_id"
  add_index "movies_themes", ["theme_id"], :name => "index_movies_themes_on_theme_id"

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "ragas", :force => true do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "rating",                      :default => 0
    t.datetime "created_at",                                  :null => false
    t.string   "rateable_type", :limit => 15, :default => "", :null => false
    t.integer  "rateable_id",                 :default => 0,  :null => false
    t.integer  "user_id",                     :default => 0,  :null => false
  end

  add_index "ratings", ["user_id"], :name => "fk_ratings_user"

  create_table "roles", :force => true do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "themes", :force => true do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "tracks", :force => true do |t|
    t.string  "title"
    t.text    "lyrics"
    t.text    "chords"
    t.integer "lenght"
    t.integer "album_id"
    t.integer "track_number"
    t.string  "video_url"
    t.integer "genre_id"
    t.integer "raga_id"
    t.integer "mood_id"
    t.integer "lyricist_id"
  end

  add_index "tracks", ["album_id"], :name => "fk_tracks_albums"
  add_index "tracks", ["genre_id"], :name => "fk_tracks_genre"
  add_index "tracks", ["lyricist_id"], :name => "fk_tracks_lyricist"
  add_index "tracks", ["mood_id"], :name => "fk_tracks_mood"
  add_index "tracks", ["raga_id"], :name => "fk_tracks_raga"

  create_table "trivias", :force => true do |t|
    t.integer "movie_id"
    t.text    "description"
  end

  add_index "trivias", ["movie_id"], :name => "fk_trivias_movies"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token",   :null => false
    t.string   "single_access_token", :null => false
    t.string   "perishable_token",    :null => false
    t.string   "openid_identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "users", ["openid_identifier"], :name => "index_users_on_openid_identifier"

end
