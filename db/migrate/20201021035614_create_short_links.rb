class CreateShortLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :short_links, id: :uuid do |t|
      t.string :url
      t.string :slug

      t.timestamps null: false
    end
  end
end
