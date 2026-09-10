class CreateCertifications < ActiveRecord::Migration[8.1]
  def change
    create_table :certifications do |t|
      t.references :profile, null: false, foreign_key: true
      t.string :name
      t.integer :year
      t.string :url

      t.timestamps
    end
  end
end
