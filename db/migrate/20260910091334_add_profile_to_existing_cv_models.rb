class AddProfileToExistingCvModels < ActiveRecord::Migration[8.1]
  def change
    add_reference :experiences, :profile, foreign_key: true
    add_reference :projects, :profile, foreign_key: true
    add_reference :skills, :profile, foreign_key: true
  end
end