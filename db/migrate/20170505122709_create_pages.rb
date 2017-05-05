class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string  :url, null: false
      t.text    :content

      t.timestamps  null: false
    end

    add_index :pages, :url, unique: true
  end
end
