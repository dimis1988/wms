class PaymentsController < ApplicationController
    include CurrentCart
    before_action :set_order

    def new
    end
    
    def create
      customer = Stripe::Customer.create({
        :email => params[:stripeEmail],
        :source => params[:stripeToken]
      })
      
      charge = Stripe::Charge.create({
        :customer => customer.id,
        :amount => (@order.total_price * 100).to_i,
        :description => 'Description of your product',
        :currency => 'eur'
      })
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Stripeeeeee!!!!." }
      end
    
      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_payment_path
    end
    # def new
    #     @order = Order.find(params[:order_id])
    # end

    # def create 
    #     10.times do |x|
    #         puts  "#{x} = bebug"
    #     end
    #     @order = Order.find(params[:order_id])
    #         puts "Start of create action"
    #         puts "Received order_id: #{params[:order_id]}"
        
    #     @session = Stripe::Checkout::Session.create({
    #         mode: 'payment',
    #         payment_method_types: ['card'],
    #         line_items: [{
    #             price: retrieve_or_create_stripe_price(@order),
    #             quantity: 1
    #         }],
    #           success_url: root_url,
    #           cancel_url:  root_url,
    #         })
    #         respond_to do |format|
    #            format.json 
    #         end
  
    # end

    # def retrieve_or_create_stripe_price(order)
    #     product = Stripe::Product.create(name: "Order ##{order.id}")
    #     price = Stripe::Price.create({
    #       unit_amount: order.total_price.to_i * 100, 
    #       currency: 'usd',
    #       product: product.id,
    #     })
    #     price.id
    #   end

    private 

    def set_order
      @order = Order.find(params[:order_id])
    end
end
