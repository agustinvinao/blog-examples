class AddMoreFieldsToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :lastname, :string
    add_column :contacts, :phone, :string
  end
end
