class AdminPanelController < ApplicationController
  http_basic_authenticate_with name: "creator", password: "wsxdcft"
	
  def products_panel
		@product = Product.new
    @all_products = Product.all.sort_by{|e| e.position_number}
		@select_options = @all_products.map{ |product| [product.title, product.id]}
		@select_options = [["Создать новую", "-1"]] + @select_options
	  gon.page="not_index"
    @our_work = OurWork.new
    @select_options_work = OurWork.all.map{ |work| [work.alt, work.id]}
    @select_options_work = [["Создать новую", "-1"]] + @select_options_work
    gon.page="not_index"
  end

	def products_change
		if (params[:commit] == "Сохранить")
			if (params[:system] == "-1")
				product = Product.new(get_product_params)
        product.save
        product.reload
				product.position_number = product.id + 1
				product.save
			else
				product = Product.find(params[:system].to_i)
				product_params = get_product_params

				if !product_params[:title].empty?
					product.title = product_params[:title]
				end
        if !product_params[:description].empty?
          product.description = product_params[:description]
        end
				if !product_params[:price].empty?
					product.price = product_params[:price]
				end
				if !product_params[:image].nil?
					product.image = product_params[:image]
				end
				product.save
			end
		else
			if (params[:system] != "-1")
			 	product = Product.find(params[:system].to_i).destroy
			end
		end
		redirect_to controller: "admin_panel", action: "products_panel"
  end

  def products_sort
    products = Product.all
    products.each do |product|
      pos_numb = params[product.id.to_s].first
      product.position_number = pos_numb
      product.save
    end
    redirect_to controller: "admin_panel", action: "products_panel"
  end

  def image_change
    if (params[:commit] == "Сохранить")
      if (params[:system] == "-1")
        our_work = OurWork.new(get_work_params)
        our_work.save
      else
        our_work = OurWork.find(params[:system].to_i)
        our_work_params = get_work_params
        if !our_work_params[:alt].empty?
          our_work.alt = get_work_params[:title]
        end
        if !our_work_params[:image].empty?
          our_work.image = get_work_params[:image]
        end
        our_work.save
      end
    else
      if (params[:system] != "-1")
        OurWork.find(params[:system].to_i).destroy
      end
    end
    redirect_to controller: "admin_panel", action: "products_panel"
  end
private

	def get_product_params
		params.require(:product).permit(:title, :description, :price, :image)
  end

  def get_work_params
    params.require(:our_work).permit(:alt, :image)
  end

end
