class AddDetailsToExperiences < ActiveRecord::Migration[8.1]
  def change
    add_column :experiences, :client, :string
    add_column :experiences, :technologies, :text
    add_column :experiences, :company_url, :string
    add_column :experiences, :project_url, :string
  end
end
