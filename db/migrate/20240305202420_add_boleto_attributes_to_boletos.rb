class AddBoletoAttributesToBoletos < ActiveRecord::Migration[7.1]
  def change
    add_column :boletos, :amount, :string
    add_column :boletos, :description, :string
    add_column :boletos, :expire_at, :date
    add_column :boletos, :customer_person_name, :string
    add_column :boletos, :customer_cnpj_cpf, :string
    add_column :boletos, :customer_zipcode, :string
    add_column :boletos, :customer_address, :string
    add_column :boletos, :customer_neighborhood, :string
    add_column :boletos, :customer_city_name, :string
    add_column :boletos, :customer_state, :string
  end
end
