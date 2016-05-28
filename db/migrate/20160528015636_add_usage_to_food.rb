class AddUsageToFood < ActiveRecord::Migration
  def change
    add_column :foods, :usage, :string
  end
end
