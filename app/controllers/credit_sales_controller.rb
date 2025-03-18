require 'prawn'
require 'prawn/table'

class CreditSalesController < ApplicationController

  before_action :set_credit_sale, only: [:cancel]

  def cancel
    if @credit_sale.update(status: 'canceled') 
      @credit_sale.sale_items.each do |item|
        article = item.article
        article.update(quantity: article.quantity + item.quantity)  
      end

      redirect_to credit_sales_path, notice: 'Venta a crédito cancelada con éxito y artículos devueltos al inventario.'
    else
      redirect_to credit_sales_path, alert: 'Hubo un error al cancelar la venta.'
    end
  end
  def pay_installment
    @sale = Sale.find(params[:id])
    installments_to_pay = params[:installments].to_i 
  
    if installments_to_pay.positive?
      new_paid_installments = [@sale.paid_installments + installments_to_pay, @sale.installments].min
      @sale.update(paid_installments: new_paid_installments)
  
      if new_paid_installments == @sale.installments
        @sale.update(status: 'approved')
      end
    end
  end
 
  def index
    @sales = Sale.includes(:user, sale_items: :article)
                 .where(sale_type: "credit")
                 .order(created_at: :desc)  # Ordenar desde la fecha de creación más reciente
  
    if params[:user_id].present?
      @sales = @sales.where(user_id: params[:user_id])
    end
  
    if params[:day].present?
      @sales = @sales.where("EXTRACT(DAY FROM date) = ?", params[:day])
    end
  
    if params[:month].present?
      @sales = @sales.where("EXTRACT(MONTH FROM date) = ?", params[:month])
    end
  
    if params[:year].present?
      @sales = @sales.where("EXTRACT(YEAR FROM date) = ?", params[:year])
    end
  
    if params[:status].present?
      @sales = @sales.where(status: params[:status])
    end
  
    @sales = @sales.page(params[:page]).per(10)
  
    respond_to do |format|
      format.html
      format.pdf do
        pdf = generate_pdf(@sales)
        send_data pdf.render, filename: "ventas_creditos.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end  
  def new
    @sale = Sale.new(sale_type: 'credit', status: 'pending')
  end

  def create
    puts "parametros recibidos: #{params.inspect}"                                                                            "parametros recibidos: #{params.inspect}"
    @sale = Sale.new(sale_params)
    @sale.user = current_user
    @sale.sale_type = 'credit'
    @sale.status = 'pending'
    if @sale.save
      redirect_to credit_sales_path, notice: 'Venta a credito registrada.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  def generate_pdf(sales)
    Prawn::Document.new do |pdf|
      pdf.text "Reporte de Ventas a Credito", size: 20, style: :bold, align: :center
      pdf.move_down 10
  
      table_data = [["ID", "Usuario", "Fecha", "Total"]]
      total_general = 0
  
      sales.each do |sale|
        total_sale = sale.sale_items.sum { |item| item.quantity * item.price }
        total_general += total_sale 
        table_data << [sale.id, sale.user.username, sale.date.strftime("%d/%m/%Y"), "$#{'%.2f' % total_sale}"]
      end
  
      column_widths = [50, 200, 150, pdf.bounds.width - 400] 
  
      pdf.table(table_data, 
        header: true, 
        row_colors: ["DDDDDD", "FFFFFF"], 
        cell_style: { padding: 5, border_width: 1, align: :center },
        column_widths: column_widths
      )
      
      pdf.move_down 10
      pdf.text "Total de ventas registradas: #{sales.count}", style: :bold, align: :right
      pdf.text "Total general de ventas: $#{'%.2f' % total_general}", style: :bold, align: :right, size: 14, color: "ff0000"
  
      pdf.render
    end
  end

  private

  def sale_params
    params.require(:sale).permit(
      :payment_method,
      :date,
      :name,
      :lastname,
      :id_number,
      :phone,
      :installments,
      sale_items_attributes: [:article_id,:quantity, :price ]
    )
  end
  def set_credit_sale
    @credit_sale = Sale.find(params[:id])
  end
end
