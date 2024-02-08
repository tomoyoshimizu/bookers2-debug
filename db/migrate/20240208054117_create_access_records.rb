class CreateAccessRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :access_records do |t|
      t.integer :book_id
      t.integer :user_id
      t.integer :count

      t.timestamps
    end
  end
end
