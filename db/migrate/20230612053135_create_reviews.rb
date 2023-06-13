class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :category, foreign_key: true,  null: false
      t.string :name, null: false
      t.string :maker, null: false
      t.text :detail, null: false
      t.timestamps
    end
  end
end
