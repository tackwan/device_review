class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true,  null: false
      t.references :review, foreign_key: true,  null: false
      t.text :comment, null: false
      t.timestamps
    end
  end
end
