class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|
      t.references :user, null: false
      t.integer :active, default: 0
      t.string :token
      t.string :ip
      t.text :useragent
      t.timestamps null: false
    end
  end
end
