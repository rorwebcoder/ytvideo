class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :youtube_id
      t.boolean :is_valid, :default => false
      t.timestamps
    end
  end
end
