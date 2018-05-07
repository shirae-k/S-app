class AddCountToPost < ActiveRecord::Migration[5.1]
  def change
      add_column :posts, :count, :integer
  end
end
