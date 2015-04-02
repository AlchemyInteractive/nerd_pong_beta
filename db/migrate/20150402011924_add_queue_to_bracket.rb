class AddQueueToBracket < ActiveRecord::Migration
  def change
    add_column :brackets, :queue, :text, default: []
    add_column :brackets, :active, :boolean, default: false
  end
end
