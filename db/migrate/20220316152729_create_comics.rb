class CreateComics < ActiveRecord::Migration[6.1]
  def change
    create_table :comics do |t|
      t.string :title
      t.text :description
      t.string :thumbnail_url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
