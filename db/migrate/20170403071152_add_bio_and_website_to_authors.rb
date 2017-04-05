class AddBioAndWebsiteToAuthors < ActiveRecord::Migration[5.0]
  def change
    add_column :authors, :bio, :text
    add_column :authors, :website, :string
  end
end
