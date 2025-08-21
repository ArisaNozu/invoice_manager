class InvoicesController < ApplicationController
  def index
        @invoices = Invoice.all  
  end

  def new
        @invoices = Invoice.new
  end

  def invoice_params
  params.require(:invoice).permit(
    :file, :status_id, :receipt_method_id, :due_date, :received_date,
    :transaction_date,  # ← 追加
    :net_amount, :tax_amount, :tax_rate_id, :memo,
    :receipt_frequency_id, :client_code, tag_list: []
  )
  end


end
