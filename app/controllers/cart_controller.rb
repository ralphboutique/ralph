class CartController < ApplicationController
  layout 'catalogue'
  before_action :set_current_cart
  before_action :set_categories
  
  def show
    @cart_items = @current_cart.cart_items.includes(:article)
  end

  def add_item
    article = Article.find(params[:article_id])
    quantity = params[:quantity]&.to_i || 1
    size = params[:size]
    color = params[:color]
    
    begin
      @current_cart.add_article(article, quantity: quantity, size: size, color: color)
      # Recargar el carrito para obtener los datos más recientes
      @current_cart.reload
      
      respond_to do |format|
        format.json { 
          render json: { 
            status: 'success', 
            message: 'Producto agregado al carrito',
            cart_count: @current_cart.total_items,
            cart_total: @current_cart.total
          }
        }
        format.html { 
          flash[:notice] = 'Producto agregado al carrito'
          redirect_back(fallback_location: catalogue_index_path)
        }
      end
    rescue => e
      respond_to do |format|
        format.json { render json: { status: 'error', message: e.message } }
        format.html { 
          flash[:alert] = "Error: #{e.message}"
          redirect_back(fallback_location: catalogue_path)
        }
      end
    end
  end

  def remove_item
    article = @current_cart.cart_items.find(params[:cart_item_id]).article
    @current_cart.remove_article(article)
    
    respond_to do |format|
      format.json { 
        render json: { 
          status: 'success', 
          message: 'Producto eliminado del carrito',
          cart_count: @current_cart.total_items,
          cart_total: @current_cart.total
        }
      }
      format.html { 
        flash[:notice] = 'Producto eliminado del carrito'
        redirect_to cart_path
      }
    end
  end
  
  def update_quantity
    cart_item = @current_cart.cart_items.find(params[:cart_item_id])
    quantity = params[:quantity].to_i
    
    @current_cart.update_quantity(params[:cart_item_id], quantity)
    
    if quantity > 0
      message = 'Cantidad actualizada'
    else
      message = 'Producto eliminado del carrito'
    end
    
    respond_to do |format|
      format.json { 
        render json: { 
          status: 'success', 
          message: message,
          cart_count: @current_cart.total_items,
          cart_total: @current_cart.total
        }
      }
      format.html { 
        flash[:notice] = message
        redirect_to cart_path
      }
    end
  end
  
  def clear
    @current_cart.clear!
    
    respond_to do |format|
      format.json { 
        render json: { 
          status: 'success', 
          message: 'Carrito vaciado',
          cart_count: 0,
          cart_total: 0
        }
      }
      format.html { 
        flash[:notice] = 'Carrito vaciado'
        redirect_to cart_path
      }
    end
  end
  
  def checkout_whatsapp
    if @current_cart.empty?
      flash[:alert] = 'Tu carrito está vacío'
      redirect_to cart_path
      return
    end
    
    # Generar mensaje de WhatsApp
    message = @current_cart.whatsapp_message
    
    # Número de WhatsApp de la tienda - ¡IMPORTANTE: Cambiar por tu número real!
    phone_number = "584121075579" # Cambia por tu número real sin +
    
    # URL encoded del mensaje
    encoded_message = URI.encode_www_form_component(message)
    whatsapp_url = "https://wa.me/#{phone_number}?text=#{encoded_message}"
    
    # NO marcar como completado aquí - dejar que el usuario confirme manualmente
    # Se puede agregar un botón "Confirmar envío" después si se necesita
    
    respond_to do |format|
      format.html { redirect_to whatsapp_url, allow_other_host: true }
      format.json { render json: { status: 'success', whatsapp_url: whatsapp_url } }
    end
  end

  private

  def set_current_cart
    if user_signed_in?
      # Usuario autenticado: buscar carrito activo del usuario
      @current_cart = current_user.carts.active.first_or_create!(
        session_id: session.id.to_s,
        status: 'active'
      )
    else
      # Usuario invitado: usar session_id
      @current_cart = Cart.for_session(session.id.to_s).active.first_or_create!(
        session_id: session.id.to_s,
        status: 'active'
      )
    end
  end
  
  def reset_current_cart
    if user_signed_in?
      @current_cart = current_user.carts.create!(
        session_id: session.id.to_s,
        status: 'active'
      )
    else
      @current_cart = Cart.create!(
        session_id: session.id.to_s,
        status: 'active'
      )
    end
  end
  
  def set_categories
    @categories = Category.all
  end
end
