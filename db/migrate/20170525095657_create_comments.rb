class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false
      t.references :article
      t.references :comment
      t.integer :support, default: 0
      t.text :content, null: false
      t.timestamps null: false
    end
  end
end
