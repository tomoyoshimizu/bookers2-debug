class AddScoreToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :score, :integer, default: 3
  end
end
