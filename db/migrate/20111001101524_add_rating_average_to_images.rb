class AddRatingAverageToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :rating_average_quality, :decimal, :default => 0, :precision => 6, :scale => 2
  end

  def self.down
    remove_column :images, :rating_average_quality
  end
end
