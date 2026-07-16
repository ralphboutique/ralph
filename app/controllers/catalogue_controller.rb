class CatalogueController < ApplicationController
	def index
		@categories = Category.all
		@last_articles = Article.limit(8).order(created_at: :desc)
	rescue => e
		Rails.logger.error "Error in catalogue#index: #{e.message}"
		@categories = []
		@last_articles = []
	end
	def products
		@category_id = params[:category_id]
		
		if @category_id.present?
			@categories = Category.all
			@articles = Article.where(category_id: @category_id,status: "active" ).page(params[:page]).per(12)
			@back = true
		else
			@categories = Category.all
			@articles = Article.where(status: "active" ).includes(:category).page(params[:page]).per(12)
		end
	end
	def details
		@categories = Category.all
    @article = Article.includes(:article_colors, :sizes).find(params[:id])
		@back = true
  	end
	def categories
		@categories = Category.all.includes(:articles)
	end
	def favorites
		@categories = Category.all
		@articles = Article.where(status: "active").includes(:category)
	end
end
