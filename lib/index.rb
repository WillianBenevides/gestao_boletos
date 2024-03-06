# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'boletosimples'
require 'awesome_print'
require 'pry'
require 'dalli'

#############################################################################
# BoletoSimples.configure
#############################################################################

BoletoSimples.configure do |c|
  c.environment = :sandbox
  c.user_agent = 'willian.bss@hotmail.com'
  c.api_token = 'IkeIEJiKDA2m0wiH3aH4jSkWyXU8Jy4WDoGRc_Gp5g0'
  # c.cache = ActiveSupport::Cache.lookup_store(:dalli_store, ['localhost:11211'], namespace: 'boletosimples_client', compress: true)
  # c.debug = true
end

#############################################################################
# BankBillet.create (error)
#############################################################################

@bank_billet = BoletoSimples::BankBillet.create(amount: 9.1)
if @bank_billet.persisted?
  puts 'Sucesso :)'
  ap @bank_billet.attributes
else
  puts 'Erro :('
  ap @bank_billet.response_errors
end

#############################################################################
# BankBillet.create (success)
#############################################################################

@bank_billet = BoletoSimples::BankBillet.create(
  amount: 800.4,
  description: 'Despesas do contrato 0012',
  expire_at: '2022-12-31',
  customer_address: 'Rua quinhentos',
  customer_address_complement: 'Sala 4',
  customer_address_number: '111',
  customer_city_name: 'Rio de Janeiro',
  customer_cnpj_cpf: '247.524.507-71',
  customer_email: 'cliente@example.com',
  customer_neighborhood: 'Sao Francisco',
  customer_person_name: 'Joao da Silva',
  customer_person_type: 'individual',
  customer_phone_number: '2112123434',
  customer_state: 'RJ',
  customer_zipcode: '12312-123',
  meta: "{\"reference_id\": \"code123\"}",
  fine_type: '1',
  fine_percentage: 1.67,
  interest_type: '1',
  interest_percentage: 1.37,
  days_for_discount: 2,
  split_accounts: [
    {
      bank_number: '246',
      account_number: '1234',
      account_digit: '5',
      agency_number: '0001',
      cnpj_cpf: '39988107226',
      name: 'José da Silva',
      amount: '23,45'
    },
    {
      bank_number: '246',
      account_number: '123468',
      account_digit: '5',
      agency_number: '0001',
      cnpj_cpf: '39988107226',
      name: 'Jhon da Silva',
      amount: '2,45'
    }
  ],
  bank_billet_account_id: 61 # quando usar carteira específica
)
if @bank_billet.persisted?
  puts 'Sucesso :)'
  ap @bank_billet.attributes
else
  puts 'Erro :('
  ap @bank_billet.response_errors
end
