ActiveAdmin.register_page "Admin message" do
  menu false
	content do
		render :partial => 'form'
	end
end