require 'net/http'
require 'json'
class ArticlesController < ApplicationController
  before_action :authenticate_user!
  def dashboard
    @total_articles =  Article.count
    @total_warehouses = Warehouse.count
    @total_categories = Category.count
  end

  def index
    @articles = if params[:query].present?
                  Article.where('title ILIKE ?', "%#{params[:query]}%").includes(:category).page(params[:page]).per(5)
                else
                  Article.includes(:category).page(params[:page]).per(5)
                end
  end

  def new
    @article = Article.new
    @categories = Category.all
    @werehouses = Warehouse.all
    @sizes = Size.all
  end

  def create
    @article = Article.new(article_params)
    @article.status = 'active'
    @werehouses = Warehouse.all
    @categories = Category.all
    @sizes = Size.all
    @colors = Color.all

    if @article.save
      save_colors(params[:article][:colors])
      redirect_to index_path, notice: 'Articulo creado exitosamente'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
    @categories = Category.all
    @werehouses = Warehouse.all
    @sizes = Size.all
    @colors = @article.article_colors.map(&:color_hex)
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
       @article.article_colors.destroy_all 
       save_colors(params[:article][:colors]) 
       redirect_to index_path, notice: 'Artículo actualizado correctamente.'
    else
       render :edit
    end
  end
  def toggle_status
    @article = Article.find(params[:id])
    
    @article.update(status: @article.status == "active" ? "inactive" : "active")

    redirect_to index_path, notice: "El estado del artículo se ha actualizado correctamente."
  end

  def destroy
    @article = Article.find_by(id: params[:id])

    if @article.nil?
      redirect_to index_path, alert: 'El artículo no existe.'
      return
    end

    if @article.sale_items.exists?
      redirect_to index_path, alert: 'No se puede eliminar porque tiene ventas asociadas.'
    else
      ArticleColor.where(article_id: @article.id).destroy_all
      @article.destroy
      redirect_to index_path, notice: 'El artículo se ha eliminado correctamente.'
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :warehouse_id, :almacen_id, :serial, :price,
                                    :category_id,:quantity, :attachment, size_ids: [])
  end
  def save_colors(colors)
    if colors.present?
      colors.each do |color_hex|
        @article.article_colors.create(color_hex: color_hex) if color_hex.present?
      end
    end
  end
end
