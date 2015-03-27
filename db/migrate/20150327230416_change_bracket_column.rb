class ChangeBracketColumn < ActiveRecord::Migration
  def change
    change_column :brackets, :bracket, :text
  end
end
