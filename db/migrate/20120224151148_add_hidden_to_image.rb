class AddHiddenToImage < ActiveRecord::Migration
  def self.up
    add_column :images, :hidden, :boolean, :default => false
  end

  def self.down
    remove_column :images, :hidden
  end
end
