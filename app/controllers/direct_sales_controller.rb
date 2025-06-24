require 'prawn'
require 'prawn/table'
class DirectSalesController < ApplicationController
  def index
    @sales = Sale.includes(:user, sale_items: :article).where(sale_type: "direct")
  
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
    respond_to do |format|
      format.html
      format.pdf do
        pdf = generate_pdf(@sales)
        send_data pdf.render, filename: "ventas_directas.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end
  
  def new
    @sale = Sale.new(sale_type: 'direct')
  end

  def create
  
    @sale = Sale.new(sale_params)
    @sale.user = current_user
    @sale.sale_type = 'direct'

    if @sale.save
      redirect_to direct_sales_path, notice: 'Venta directa registrada.'
    else
      render :new
    end
  end
  def generate_pdf(sales)
    Prawn::Document.new do |pdf|
      pdf.text "Reporte de Ventas Directas", size: 20, style: :bold, align: :center
      pdf.move_down 10
  
      # Definir la tabla con anchos dinámicos
      table_data = [["ID", "Usuario", "Fecha", "Total"]]
      total_general = 0 # Inicializamos el total general
  
      sales.each do |sale|
        total_sale = sale.sale_items.sum { |item| item.quantity * item.price }
        total_general += total_sale # Acumulamos el total de todas las ventas
        table_data << [sale.id, sale.user.username, sale.date.strftime("%d/%m/%Y"), "$#{'%.2f' % total_sale}"]
      end
  
      # Calcular el ancho de cada columna para que la tabla ocupe todo el ancho
      column_widths = [50, 200, 150, pdf.bounds.width - 400] # Ajusta estos valores según sea necesario
  
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
      sale_items_attributes: [:article_id, :quantity, :price]
    )
  end
end 