class CreateProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :headline
      t.text :bio
      t.string :location
      t.string :email
      t.string :linkedin_url
      t.string :github_url

      t.timestamps
    end
  end
end
