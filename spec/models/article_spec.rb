require 'rails_helper'

RSpec.describe Article, type: :model do
  # 🏗️ TESTS DE VALIDACIONES
  describe "validations" do
    it "is valid with valid attributes" do
      category = create(:category) # Usaremos Factory Bot
      warehouse = create(:warehouse)
      
      article = Article.new(
        title: "Vestido Elegante",
        price: 50.0,
        quantity: 10,
        category: category,
        warehouse: warehouse
      )
      
      expect(article).to be_valid
    end

    it "is invalid without a title" do
      article = Article.new(title: nil)
      expect(article).to_not be_valid
      expect(article.errors[:title]).to include("can't be blank")
    end

    it "is invalid without a price" do
      article = Article.new(price: nil)
      expect(article).to_not be_valid
      expect(article.errors[:price]).to include("can't be blank")
    end

    it "is invalid with negative quantity" do
      article = Article.new(quantity: -1)
      expect(article).to_not be_valid
      expect(article.errors[:quantity]).to include("must be greater than or equal to 0")
    end
  end

  # 🔗 TESTS DE RELACIONES
  describe "associations" do
    it "belongs to category" do
      expect(Article.reflect_on_association(:category).macro).to eq(:belongs_to)
    end

    it "belongs to warehouse" do
      expect(Article.reflect_on_association(:warehouse).macro).to eq(:belongs_to)
    end

    it "has many sale_items" do
      expect(Article.reflect_on_association(:sale_items).macro).to eq(:has_many)
    end

    it "has and belongs to many sizes" do
      expect(Article.reflect_on_association(:sizes).macro).to eq(:has_and_belongs_to_many)
    end
  end

  # 🛡️ TESTS DE LÓGICA DE NEGOCIO
  describe "business logic" do
    let(:article) { create(:article, quantity: 5) }
    let(:sale) { create(:sale) }

    context "when article has sales" do
      before do
        create(:sale_item, article: article, sale: sale, quantity: 2)
      end

      it "cannot be destroyed" do
        expect { article.destroy }.to_not change(Article, :count)
        expect(article.errors[:base]).to include("No se puede eliminar porque tiene ventas asociadas.")
      end
    end

    context "when article has no sales" do
      it "can be destroyed" do
        expect { article.destroy }.to change(Article, :count).by(-1)
      end
    end
  end

  # 📊 TESTS DE SCOPES Y MÉTODOS PERSONALIZADOS
  describe "scopes and custom methods" do
    # Aquí agregaremos más tests cuando tengas scopes
    it "responds to title" do
      article = create(:article)
      expect(article).to respond_to(:title)
    end
  end
end