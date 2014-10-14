class PagesController < ApplicationController
	def index
        @products = Product.all.sort_by{|e| e.position_number}
        @client = Client.new
        @our_work = OurWork.all
        gon.page = "index"
	end
	
	def send_email 
        @client = Client.new(user_params)
        if @client.save
            AppMailer.welcome_email(@client).deliver
        end
    end

private

def user_params
    params.require(:client).permit(:name, :number, :address)
end

end