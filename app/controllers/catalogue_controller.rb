class CatalogueController < ApplicationController
	def index
		@categories = Category.all
		@last_articles = Article.last(8)
	end
	def products
		@category_id = params[:category_id]
		
		if @category_id.present?
			@categories = Category.all
			@articles = Article.where(category_id: @category_id).page(params[:page]).per(12)
			@back = true
		else
			@categories = Category.all
			@articles = Article.includes(:category).page(params[:page]).per(12)
		end
	end
	def details
		@categories = Category.all
    @article = Article.includes(:article_colors, :sizes).find(params[:id])
		# @articles = Article.where(id: params[:id]).select(:size_id).includes(:size)
		@back = true
		# @colors = Article.where(id: params[:id]).select(:color_id)
  end
	def categories
		@categories = Category.all.includes(:articles)
	end
end
