require 'httparty'

class BoletosController < ApplicationController
  before_action :set_boleto, only: [:show, :edit, :update, :destroy]

  def index
    @boletos = Boleto.all
  end
  
  
  def new
    @boleto = Boleto.new
  end

  def create
    boleto_params = {
      amount: params[:boleto][:amount],
      description: params[:boleto][:description],
      expire_at: params[:boleto][:expire_at],
      customer_person_name: params[:boleto][:customer_person_name],
      customer_cnpj_cpf: params[:boleto][:customer_cnpj_cpf],
      customer_zipcode: params[:boleto][:customer_zipcode],
      customer_address: params[:boleto][:customer_address],
      customer_neighborhood: params[:boleto][:customer_neighborhood],
      customer_city_name: params[:boleto][:customer_city_name],
      customer_state: params[:boleto][:customer_state]
    }
  
    puts "Creating Boleto with params: #{boleto_params}"
  
    @boleto = Boleto.new(boleto_params)
  
    puts "Boleto attributes: #{boleto_params}"
  
    if @boleto.valid?
      if enviar_boleto_para_kobana(@boleto)
        # Lógica de sucesso após enviar para Kobana
        redirect_to boletos_path, turbostream: %{
          turbo-stream.replace :body, partial: "boletos/index", collection: @boletos
        }
      else
        flash.now[:alert] = "Erro ao criar boleto: Falha ao enviar para Kobana"
        render :new, status: :unprocessable_entity
      end
    else
      render :new, status: :unprocessable_entity
    end    
  end

  def destroy
    @boleto = Boleto.find(params[:id])
    @boleto.destroy
    redirect_to boletos_path, notice: 'Boleto foi deletado com sucesso.'
  end

  private

  def boleto_params
    params.require(:boleto).permit(:amount, :description, :expire_at, :customer_person_name)
  end
  

  def set_boleto
    @boleto = Boleto.find(params[:id])
  end

  def handle_api_errors(response)
    puts "Código de status da resposta da API: #{response.code}"
    if valid_json?(response.body)
      errors = JSON.parse(response.body)['errors']
  
      if errors.is_a?(Hash)
        errors.each do |field, messages|
          # ...
        end
      else
        # ...
      end
    else
      puts "A resposta da API não é um JSON válido: #{response.body}"
    end
  end
  
  def valid_json?(json)
    JSON.parse(json)
    return true
  rescue JSON::ParserError
    return false
  end
  
  def listar_boletos
    url = 'https://api-sandbox.kobana.com.br/v1/bank_billets'
    headers = {
      'Content-Type' => 'application/json',
      'Authorization' => 'Bearer IkeIEJiKDA2m0wiH3aH4jSkWyXU8Jy4WDoGRc_Gp5g0'
    }
  
    response = HTTParty.get(url, headers: headers)
  
    if response.success?
      boletos_data = JSON.parse(response.body)
      puts "Dados dos boletos recebidos: #{boletos_data}"
  
      boletos = boletos_data.map do |boleto_data|
        Boleto.create(
          amount: boleto_data['amount'],
          description: boleto_data['description'],
          expire_at: boleto_data['expire_at'],
          customer_person_name: boleto_data['customer_person_name'],
          customer_cnpj_cpf: boleto_data['customer_cnpj_cpf'],
          customer_zipcode: boleto_data['customer_zipcode'],
          customer_address: boleto_data['customer_address'],
          customer_neighborhood: boleto_data['customer_neighborhood'],
          customer_city_name: boleto_data['customer_city_name'],
          customer_state: boleto_data['customer_state']
        )
      end

      @boletos = boletos
      puts "Boletos listados com sucesso: #{@boletos.inspect}"
  else
    handle_api_errors(response)
  end
end
  
  def enviar_boleto_para_kobana(boleto)
    url = 'https://api-sandbox.kobana.com.br/v1/bank_billets'
    headers = {
      'Content-Type' => 'application/json',
      'Authorization' => 'Bearer IkeIEJiKDA2m0wiH3aH4jSkWyXU8Jy4WDoGRc_Gp5g0'
    }

    boleto_params = {
      amount: boleto[:amount],
      description: boleto[:description],
      expire_at: boleto[:expire_at],
      customer_person_name: boleto[:customer_person_name],
      customer_cnpj_cpf: boleto[:customer_cnpj_cpf],
      customer_zipcode: boleto[:customer_zipcode],
      customer_address: boleto[:customer_address],
      customer_neighborhood: boleto[:customer_neighborhood],
      customer_city_name: boleto[:customer_city_name],
      customer_state: boleto[:customer_state]
    }
  
    response = HTTParty.post(url, body: boleto_params.to_json, headers: headers)
  
    if response.success?
      true
    else
      handle_api_errors(response)
      false
    end
  end

  def criar_boleto(boleto_params)
    uri = URI.parse('https://api-sandbox.kobana.com.br/v1/bank_billets')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    request['Authorization'] = "Bearer IkeIEJiKDA2m0wiH3aH4jSkWyXU8Jy4WDoGRc_Gp5g0"
    request.body = boleto_params.to_json

    response = http.request(request)
    JSON.parse(response.body)
  end
end
