class InvoicesController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  def index
        @invoices = Invoice.all  
  end

  def new
        @invoice = Invoice.new
  end

  def create
    @invoice = current_user.invoices.new(invoice_params)
    if @invoice.save
      redirect_to invoices_path, notice: "投稿しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def invoice_params
  params.require(:invoice).permit(
    :file, :status, :receipt_method, :due_date, :received_date,
    :transaction_date, 
    :net_amount, :tax_amount, :tax_rate, :memo,
    :receipt_frequency, :client_code, :subject, tag_list: []
  )
  end


end
