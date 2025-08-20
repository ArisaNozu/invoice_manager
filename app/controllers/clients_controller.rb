class ClientsController < ApplicationController
  def lookup
    code = params[:client_code].to_s
    client = Client.find_by(client_code: code)
    if client
      render json: {
        name: client.name,
        invoice_registration_number: client.invoice_registration_number,
        is_qualified_invoice_issuer: client.is_qualified_invoice_issuer
      }
    else
      render json: { error: "not found" }, status: :not_found
    end
  end

  def info
    client = Client.find_by(id: params[:id])
    if client
      render json: {
        name: client.name,
        invoice_registration_number: client.invoice_registration_number,
        is_qualified_invoice_issuer: client.is_qualified_invoice_issuer
      }
    else
      render json: { error: "not found" }, status: :not_found
    end
  end
end
