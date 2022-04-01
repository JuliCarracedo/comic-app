class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages do |t|
      t.integer :number
      t.string :page_url

      t.timestamps
    end
  end
end
