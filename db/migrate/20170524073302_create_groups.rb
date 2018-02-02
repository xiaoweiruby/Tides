class CreateGroups < ActiveRecord::Migration[5.0]
    def change
        create_table :groups do |t|
            t.string :name, null: false
            t.text :description, null: false
            t.integer :active, null: false, default: 1
            t.timestamps null: false
        end
    end
end
