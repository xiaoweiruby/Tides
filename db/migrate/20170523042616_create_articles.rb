class CreateArticles < ActiveRecord::Migration[5.0]
    def change
        create_table :articles do |t|
            t.references :user
            t.references :category
            t.string :title
            t.text :content
            t.timestamps null: false
        end
    end
end
