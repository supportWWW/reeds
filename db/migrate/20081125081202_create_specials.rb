class CreateSpecials < ActiveRecord::Migration
  def self.up
    create_table :specials do |t|
      t.string :title
      t.string :title_permalink
      t.text :text
      t.text :rendered_text

      t.timestamps
    end
  end

  def self.down
    drop_table :specials
  end
end
