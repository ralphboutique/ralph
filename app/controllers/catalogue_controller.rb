class CatalogueController < ApplicationController
	def index
		Rails.logger.info "DATABASE_URL present: #{ENV['DATABASE_URL'].present?}"
		Rails.logger.info "Database config: #{ActiveRecord::Base.connection_config}"
		
		@categories = Category.all
		@last_articles = Article.limit(8).order(created_at: :desc)
		
		Rails.logger.info "Categories found: #{@categories.count}"
		Rails.logger.info "Articles found: #{@last_articles.count}"
	rescue => e
		Rails.logger.error "Error in catalogue#index: #{e.message}"
		Rails.logger.error "Backtrace: #{e.backtrace.first(5).join("\n")}"
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
end
