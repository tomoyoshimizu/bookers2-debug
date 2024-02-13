class CreateEventMails < ActiveRecord::Migration[6.1]
  def change
    create_table :event_mails do |t|
      t.string :title
      t.text :content

      t.integer :sender_id
      t.integer :group_id

      t.timestamps
    end
  end
end
