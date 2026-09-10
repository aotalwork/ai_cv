class AddProfileDetailsToProfiles < ActiveRecord::Migration[8.1]
  def change
    add_column :profiles, :phone, :string
  end
end
