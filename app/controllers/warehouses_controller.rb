class WarehousesController < ApplicationController
  def show
    if params[:query].present?
      @warehouses = Warehouse.where('title ILIKE ?', "%#{params[:query]}%").page(params[:page]).per(5)
    else
      @warehouses = Warehouse.page(params[:page]).per(5)
    end
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)

    if @warehouse.save
      redirect_to show_warehouses_path, notice: 'Almacen creado exitosamente'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @warehouse = Warehouse.find(params[:id])
  end

  def update
    @warehouse = Warehouse.find(params[:id])
    if @warehouse.update(warehouse_params)
      redirect_to show_warehouses_path, notice: 'Almacen editado exitosamente'
    else
      render :edit
    end
  end
  def destroy
    @warehouse = Warehouse.find(params[:id])
    if @warehouse.destroy
     redirect_to show_warehouses_path, notice: 'Almacen eliminador exitosamente.'
    else
       redirect_to show_warehouses_path, alert: 'No se ha podido eliminar tiene un articulo asociado.'
    end 
  end

  private
  def warehouse_params
    params.require(:warehouse).permit(:title)
  end
end
