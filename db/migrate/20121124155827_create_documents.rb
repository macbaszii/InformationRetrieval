class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.text :user_text
      t.string :crawl_url

      t.timestamps
    end
  end
end
