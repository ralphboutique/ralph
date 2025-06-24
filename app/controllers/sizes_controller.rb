class SizesController < ApplicationController
  def show
    if params[:query].present?
      @sizes =  Size.where('title ILIKE ?', "%#{params[:query]}%").page(params[:page]).per(5)
    else
      @sizes = Size.page(params[:page]).per(5)
    end
  end

  def new
    @size = Size.new
  end

  def create
    @size = Size.new(size_params)
    if @size.save
      redirect_to show_size_path, notice: 'Talla creada exitosamente'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @size = Size.find(params[:id])
  end

  def update
    @size = Size.find(params[:id])
    if @size.update(size_params)
      redirect_to show_size_path, notice: 'Talla editada exitosamente'
    else
      render :edit
    end
  end
  def destroy
    @size = Size.find(params[:id])
   if @size.destroy
    redirect_to show_size_path, notice: 'Talla eliminada exitosamente.'
   else 
    redirect_to show_size_path, alert: 'No se ha podido eliminar porque esta asociado a un articulo.'
   end 
  end

  private
  def size_params
    params.require(:size).permit(:title)
  end
end
