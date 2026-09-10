class CreateRecommendations < ActiveRecord::Migration[8.1]
  def change
    create_table :recommendations do |t|
      t.references :profile, null: false, foreign_key: true
      t.string :author
      t.string :author_role
      t.string :company
      t.date :date
      t.text :summary
      t.text :content

      t.timestamps
    end
  end
end
