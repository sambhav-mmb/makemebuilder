class OrdersController < ApplicationController

	def create
		@order = current_cart.build_order
		@order.ip_address = request.remote_ip
		if @order.save
			@order.update(
				name: current_cart.billing_name,
				mobile: current_cart.billing_mobile,
				email: current_cart.billing_email,
				billing_address_1: current_cart.billing_address_line_1,
				billing_address_2: current_cart.billing_address_line_2,
				country: current_cart.billing_country,
				state: current_cart.billing_state,
				city: current_cart.billing_city,
				zip_code: current_cart.billing_zip_code,
			)
			current_cart.update(is_ordered: true)

			save_path = Rails.root.join('pdfs',"order_#{@order.id}.pdf")
	    template_path = "orders/pdf"
	    create_pdf(save_path, template_path)
	    send_file(
	      save_path,
	      filename: "order_#{@order.id}.pdf",
	      type: "application/pdf"
	    )

			UserMailer.checkout_mail(current_user, @order).deliver_later
			UserMailer.checkoutadmin_mail(current_user, @order).deliver_later
			
			flash[:success] = 'Enquiry confirmed'
			redirect_to root_path
		end
	end

	private

		def create_pdf(file_path, template_path)
      pdf = render_to_string pdf: 'document',
        template: template_path,
        layout: "pdf",
        encoding: "UTF-8"
        # margin: {bottom: 30},
        # footer: {html: {template: 'layouts/pdf_footer.html.erb'}}
      File.open(file_path, 'wb') do |file|
        file << pdf
      end
    end

end