class CreateUsers < ActiveRecord::Migration[5.0]
    def change
        create_table :users do |t|
            t.references :group
            t.string :name, null: false
            t.string :telphone
            t.string :email, null: false
            t.string :password, null: false
            t.timestamps null: false
        end
    end
end
