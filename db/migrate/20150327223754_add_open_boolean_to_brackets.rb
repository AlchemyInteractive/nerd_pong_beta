class AddOpenBooleanToBrackets < ActiveRecord::Migration
  def change
    add_column :brackets, :open, :boolean, default: true
  end
end
