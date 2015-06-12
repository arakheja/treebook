class CreateBreakingNews < ActiveRecord::Migration
  def change
    create_table :breaking_news do |t|
      t.string :name
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
