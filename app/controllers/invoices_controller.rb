# frozen_string_literal:true

class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[show edit update destroy]

  def index
    @invoices = current_company.invoices.ordered
  end

  def show
    @line_item_dates = @invoice.line_item_dates.includes(:line_items).ordered
  end

  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = current_company.invoices.build(invoice_params)

    if @invoice.save
      respond_to do |format|
        format.html { redirect_to invoices_path, notice: 'Invoice was successfully created.' } # This is an alternative notation to flash[:notice] = ...
        format.turbo_stream { flash.now[:notice] = 'Invoice was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @invoice.update(invoice_params)
      respond_to do |format|
        format.html { redirect_to invoices_path, notice: 'Invoice was successfully updated.' } # This is an alternative notation to flash[:notice] = ...
        format.turbo_stream { flash.now[:notice] = 'Invoice was successfully updated.' }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to invoices_path, notice: 'Invoice was successfully destroyed.' } # This is an alternative notation to flash[:notice] = ...
      format.turbo_stream { flash.now[:notice] = 'Invoice was successfully destroyed.' }
    end
  end

  private

  def set_invoice
    @invoice = current_company.invoices.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:name)
  end
end
