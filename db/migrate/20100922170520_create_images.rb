class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.integer :text_id
      t.integer :user_id
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
