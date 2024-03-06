# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_03_05_202420) do
  create_table "boletos", force: :cascade do |t|
    t.string "numero"
    t.float "valor"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "amount"
    t.string "description"
    t.date "expire_at"
    t.string "customer_person_name"
    t.string "customer_cnpj_cpf"
    t.string "customer_zipcode"
    t.string "customer_address"
    t.string "customer_neighborhood"
    t.string "customer_city_name"
    t.string "customer_state"
  end

end
