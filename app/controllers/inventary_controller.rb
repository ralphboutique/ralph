require 'prawn'
class InventaryController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = Article.all

    if params[:warehouse_id].present?
      @articles = @articles.where(warehouse_id: params[:warehouse_id])
    end

    if params[:query].present?
      @articles = @articles.where("title ILIKE ?", "%#{params[:query]}%")
    end

    @articles = @articles.page(params[:page]) 
    @warehouses = Warehouse.all 
  end
  def generate_pdf
    @articles = Article.all
  
    if params[:warehouse_id].present?
      @articles = @articles.where(warehouse_id: params[:warehouse_id])
    end
  
    if params[:query].present?
      @articles = @articles.where("title ILIKE ?", "%#{params[:query]}%")
    end
  
    pdf = Prawn::Document.new
    pdf.text "Inventario de Artículos", size: 20, style: :bold, align: :center
    pdf.move_down 10
  
    if params[:warehouse_id].present?
      warehouse = Warehouse.find_by(id: params[:warehouse_id])
      pdf.text "Almacén: #{warehouse&.title}", size: 14, style: :italic
      pdf.move_down 10
    end

    table_data = [["Nombre", "Precio", "Categoría", "Cantidad"]] +
                 @articles.map { |article| [article.title, "#{article.price} $", article.category.title, article.quantity] }
  
    pdf.table(table_data, header: true, width: 500) do
      row(0).font_style = :bold
      self.row_colors = ["F0F0F0", "FFFFFF"]
      self.cell_style = { padding: 5, borders: [:bottom] }
    end
  
    send_data pdf.render, filename: "inventario.pdf", type: "application/pdf", disposition: "inline"
  end  
end

