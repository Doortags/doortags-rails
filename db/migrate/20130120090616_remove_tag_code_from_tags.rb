class RemoveTagCodeFromTags < ActiveRecord::Migration
  def up
    remove_column :tags, :tag_code
  end

  def down
    add_column :tags, :tag_code, :string
  end
end
