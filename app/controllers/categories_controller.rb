class CategoriesController < ApplicationController
  def show
    if params[:query].present?
      @categories = Category.where('title ILIKE ?', "%#{params[:query]}%").page(params[:page]).per(5)
    else
      @categories = Category.page(params[:page]).per(5)
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to show_category_path, notice: 'Categoria creada exitosamente'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to show_category_path, notice: 'Categoria editada exitosamente'
    else
      render :edit
    end
  end
  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to show_category_path, notice: 'Categoría eliminada correctamente.'
    else
      redirect_to show_category_path, alert: 'No se puede eliminar la categoría porque está asociada a productos.'
    end
  end

  private
  def category_params
    params.require(:category).permit(:title)
  end
end
