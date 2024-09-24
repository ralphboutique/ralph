class ArticlesController < ApplicationController
  def index
    if params[:query].present?
      @articles = Article.where('title LIKE ?', "%#{params[:query]}%").includes(:category).page(params[:page]).per(5)
    else
      @articles = Article.includes(:category).page(params[:page]).per(5)
    end
  end

  def new
    @article = Article.new
    @categories = Category.all
    @werehouses = Werehouse.all
    @sizes = Size.all
    @colors = Color.all
  end

  def create
    @article = Article.new(article_params)
    @werehouses = Werehouse.all
    @categories = Category.all
    @sizes = Size.all
    @colors = Color.all

    if @article.save
      redirect_to index_path, notice: 'Articulo creado exitosamente'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
    @categories = Category.all
    @werehouses = Werehouse.all
    @sizes = Size.all
    @colors = Color.all
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to index_path, notice: 'Articulo editado exitosamente'
    else
     
      render :edit
    end
  end
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to index_path, notice: 'Article was successfully destroyed.'
  end

  private
  def article_params
    params.require(:article).permit(:title, :desciption, :werehouse_id, :color_id, :size_id, :almacen_id, :serial, :price, :category_id, :image)
  end
end
