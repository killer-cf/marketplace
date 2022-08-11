class AlterColumnOfAdmins < ActiveRecord::Migration[7.0]
  def change
    change_table :admins do |t|
      t.remove :approved
    end
  end
end
