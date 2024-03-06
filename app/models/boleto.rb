# app/models/boleto.rb
class Boleto < ApplicationRecord
  validates :amount, presence: true
  validates :description, uniqueness: { scope: [:amount, :customer_person_name] }
  validates :expire_at, presence: true
  validates :customer_person_name, presence: true
end
