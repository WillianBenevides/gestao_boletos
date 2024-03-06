class CreateBoletos < ActiveRecord::Migration[7.1]
  def change
    create_table :boletos do |t|
      t.string :numero
      t.float :valor
      t.string :status

      t.timestamps
    end
  end
end
