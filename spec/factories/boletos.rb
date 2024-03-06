FactoryBot.define do
    factory :boleto do
      amount { 100 }
      customer_person_name { 'John Doe' }
      description { 'Teste' }
    end
  end