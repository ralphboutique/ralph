class DirectSalesController < ApplicationController
  def index
    @sales = Sale.includes(:sale_items).where(sale_type: "direct")
  end
  def new
    @sale = Sale.new(sale_type: 'direct')
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.user = current_user
    @sale.sale_type = 'direct'
  
    if @sale.save
      if params[:sale][:sale_items_attributes].present?
        params[:sale][:sale_items_attributes].each do |_, item|
          @sale.sale_item.create(
            article_id: item[:article_id],
            quantity: item[:quantity],
            price: item[:price]
          )
        end
      end
  
      redirect_to direct_sales_path, notice: 'Venta directa registrada.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def sale_params
    params.require(:sale).permit(:payment_method, :date, :name, :lastname, :id_number, :phone ,sale_items_attributes: [:article_id, :quantity, :price])
  end
end
