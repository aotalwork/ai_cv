class CreateEducations < ActiveRecord::Migration[8.1]
  def change
    create_table :educations do |t|
      t.references :profile, null: false, foreign_key: true
      t.string :institution
      t.string :degree
      t.integer :start_year
      t.integer :end_year
      t.string :url

      t.timestamps
    end
  end
end
