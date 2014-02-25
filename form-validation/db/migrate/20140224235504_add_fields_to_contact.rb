class AddFieldsToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :tos, :boolean
    add_column :contacts, :points, :integer
  end
end
