class CartController < ApplicationController
  def show
    @categories = Category.all
    @cart_items = JSON.parse(cookies[:cart_items] || "[]")
  end

  def add_item
    @categories = Category.all
    item = params[:item]
    cart_items = JSON.parse(cookies[:cart_items] || "[]")
    cart_items << item unless cart_items.include?(item)
    cookies[:cart_items] = { value: JSON.generate(cart_items), expires: 1.week.from_now }
    render json: { status: 'success', message: 'Item added to cart' }
  end

  def remove_item
    @categories = Category.all
    item = params[:item]
    cart_items = JSON.parse(cookies[:cart_items] || "[]")
    cart_items.delete(item)
    cookies[:cart_items] = { value: JSON.generate(cart_items), expires: 1.week.from_now }
    render json: { status: 'success', message: 'Item removed from cart' }
  end
end
