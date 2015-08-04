include ApplicationHelper
ActiveAdmin.register_page "Dashboard" do
    menu false
  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   # span class: "blank_slate" do
    #   #   span I18n.t("active_admin.dashboard_welcome.welcome")
    #   #   small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   # end
    # end

            @interests = Interest.all
            @interest_data = {}
            @interests.each do |i|
             @interest_data["Users of #{i.interest_name}"] = i.users.count
            end
            @age_data ={}
            @rate_data = {}
            @count1 =0 
            @count2 =0
            @count3 =0
            @count4 =0
            @count5 =0

            @rt1=0
            @rt2=0
            @rt3=0
            @rt4=0
            @rt5=0
            User.all.each do |u|
                @age = find_age(u)
               if @age < 18 
                  @count1 +=1
               elsif @age >=18 and @age <=21
                  @count2 +=1
               elsif @age >=22 and @age <=25
                  @count3 +=1
               elsif @age >=26 and @age <= 30
                  @count4 +=1
               else
                 @count5 +=1
               end
               @rating = user_rating(u.id) 
               if @rating < 0
                    @rt1 +=1
                elsif @rating >=0 and @rating <=50
                    @rt2 +=1
                elsif @rating >51 and @rating <100
                    @rt3 +=1
                else @rating >= 100
                    @rt4 +=1
                end                      
            end

            @age_data["Users of less than 18 years old"] = @count1
            @age_data["Users between 18 to 21 years old"]=@count2
            @age_data["Users between 22 to 25 years old"]=@count3
            @age_data["Users between 26 to 30 years old"]=@count4
            @age_data["Users greater than 30 years old"]= @count5

            @rate_data["Negarive rating users"] = @rt1
            @rate_data["Users between 0% to 50% rating"]=@rt2
            @rate_data["Users above 50% rating"]=@rt3
            @rate_data["Users with 100% rating"]=@rt4

    

    columns do
      column do
       
        # panel "Recent Posts" do
         render partial: 'users/interest',locals: { :@interest_data =>   @interest_data}
        # end
      end

      column do
        # panel "Info" do
           render partial: 'users/rate_chart',locals: { :@age_data => @age_data,:@rate_data => @rate_data}
        # end
      end
    end
  end # content
end
