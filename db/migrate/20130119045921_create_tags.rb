class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :tag_code
      t.string :location
      t.integer :user_id

      t.timestamps
    end
  end
end
