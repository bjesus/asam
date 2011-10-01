class AddGuidelinesToImage < ActiveRecord::Migration
  def self.up
    add_column :images, :guidelines, :text, :default => ""
  end

  def self.down
  	remove_column :images, :guidelines
  end
end
