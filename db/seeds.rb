# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@admin_user = AdminUser.create(email: "admin@example.com", password: "password")

@user1 = User.create(provider: "facebook", user_id: "11111",authentication_token: "5abcdefghjklm1234r",latitude: 28.6433175,longitude: 77.3381894,current_city: "Ghaziabad",online: true,address: "411, Sector 3, Vaishali, Ghaziabad, Uttar Pradesh 201012, India")
@user2 = User.create(provider: "facebook", user_id: "22222",authentication_token: "oabcdefgijklm1234d",latitude: 26.3975746,longitude: 86.1599149,current_city: "Rajnagar",online: true,address: "Madhubani - Rajnagar - Khutauna Road, Rajnagar, Bihar 847235, India")
@user3 = User.create(provider: "facebook", user_id: "33333",authentication_token: "uabcdfghijklm123ef",latitude: 28.6741058,longitude: 77.3381894,current_city: "Ghaziabad",online: true,address: "411, Sector 3, Vaishali, Ghaziabad, Uttar Pradesh 201012, India")
@user4 = User.create(provider: "facebook", user_id: "44444",authentication_token: "fabcdefghijkl123ds",latitude: 26.3975746,longitude: 86.1599149,current_city: "Rajnagar",online: true,address: "Madhubani - Rajnagar - Khutauna Road, Rajnagar, Bihar 847235, India")
@user5 = User.create(provider: "facebook", user_id: "55555",authentication_token: "sabcdefghijklm12li",latitude: 28.5457867,longitude: 77.2639382,current_city: "New Delhi",online: true,address: "Ma Anandmayee Marg, NSIC Estate, Okhla Phase III, Okhla Industrial Area, New Delhi, Delhi 110020, India")

@profile1 = Profile.create(email: "#{@user1.user_id}@facebook.com", fb_email: "user1@domain.com",first_name: "ABCD", image: "v1437647939/pgk1tslryt8vymvbejyo.png" ,last_name: "Aab", gender: "male", status: false, user_id: @user1.id,dob: "1997-07-16",location: "Demo location")
@profile2 = Profile.create(email: "#{@user2.user_id}@facebook.com", fb_email: "user2@domain.com",first_name: "EFGH", image: "v1437647939/pgk1tslryt8vymvbejyo.png" ,last_name: "Eef", gender: "male", status: false, user_id: @user2.id,dob: "1996-07-16",location: "Demo location")
@profile3 = Profile.create(email: "#{@user3.user_id}@facebook.com", fb_email: "user3@domain.com",first_name: "IJKL", image: "v1437647939/pgk1tslryt8vymvbejyo.png" ,last_name: "Iij", gender: "male", status: false, user_id: @user3.id,dob: "1992-07-16",location: "Demo location")
@profile4 = Profile.create(email: "#{@user4.user_id}@facebook.com", fb_email: "user4@domain.com",first_name: "MNOP", image: "v1437647939/pgk1tslryt8vymvbejyo.png" ,last_name: "Mmn", gender: "male", status: false, user_id: @user4.id,dob: "1990-07-16",location: "Demo location")
@profile5 = Profile.create(email: "#{@user5.user_id}@facebook.com", fb_email: "user5@domain.com",first_name: "QRST", image: "v1437647939/pgk1tslryt8vymvbejyo.png" ,last_name: "Qqr", gender: "male", status: false, user_id: @user5.id,dob: "1995-07-16",location: "Demo location")

@device1 = @user1.devices.create(device_id: "dbcdef",device_type: "Android")
@device2 = @user2.devices.create(device_id: "abcdeg",device_type: "Android")
@device3 = @user3.devices.create(device_id: "abcdfg",device_type: "Android")
@device4 = @user4.devices.create(device_id: "abdefg",device_type: "Android")
@device5 = @user5.devices.create(device_id: "bcdefg",device_type: "Android")

@rating1 = @user1.ratings.create(rate: "-1", rater_id: @user2.id)
@rating2 = @user2.ratings.create(rate: "1", rater_id: @user1.id)
@rating3 = @user3.ratings.create(rate: "-1", rater_id: @user4.id, reason: "abusive/inappropriate language")
@rating4 = @user4.ratings.create(rate: "-1", rater_id: @user3.id, reason: "abusive/inappropriate language")
@rating5 = @user5.ratings.create(rate: "1", rater_id: @user2.id)

@group1 = Group.create(group_admin: @user1.id)
@group2 = Group.create(group_admin: @user2.id)
@group3 = Group.create(group_admin: @user3.id)
@group4 = Group.create(group_admin: @user4.id)
@group5 = Group.create(group_admin: @user5.id)

@message1  = @user1.messages.create(group_id: 1, content: "message1")
@message2  = @user1.messages.create(group_id: 2, content: "message2")
@message3  = @user2.messages.create(group_id: 3, content: "message3")
@message4  = @user2.messages.create(group_id: 4, content: "message4")
@message5  = @user3.messages.create(group_id: 5, content: "message5")
@message6  = @user3.messages.create(group_id: 1, content: "message6")
@message7  = @user4.messages.create(group_id: 2, content: "message7")
@message8  = @user4.messages.create(group_id: 3, content: "message8")
@message9  = @user5.messages.create(group_id: 4, content: "message9")
@message10 = @user5.messages.create(group_id: 5, content: "message10")

@post1 = @user1.posts.create(title: "post1", content: "content1",user_type: "user", image: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@post2 = @user2.posts.create(title: "post2", content: "content2",user_type: "user", image: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@post3 = @user3.posts.create(title: "post3", content: "content3",user_type: "user", image: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@post4 = @user4.posts.create(title: "post4", content: "content4",user_type: "user", image: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@post5 = @user5.posts.create(title: "post5", content: "content5",user_type: "user", image: "v1437647939/pgk1tslryt8vymvbejyo.png" )

@comment1  = @post1.comments.create(reply: "Hello",user_id: @user1.id  )
@comment2  = @post1.comments.create(reply: "Hii",user_id: @user2.id )
@comment3  = @post2.comments.create(reply: "Hello",user_id: @user1.id )
@comment4  = @post2.comments.create(reply: "Hii",user_id: @user2.id )
@comment5  = @post3.comments.create(reply: "Hello",user_id: @user3.id )
@comment6  = @post3.comments.create(reply: "Hii",user_id: @user4.id )
@comment7  = @post4.comments.create(reply: "Hello",user_id: @user3.id )
@comment8  = @post4.comments.create(reply: "Hii",user_id: @user5.id )
@comment9  = @post5.comments.create(reply: "Hii",user_id: @user4.id )
@comment10 = @post5.comments.create(reply: "Hello",user_id: @user5.id )

@category1 = Category.create(category_name: "Category1")
@category2 = Category.create(category_name: "Category2")
@category3 = Category.create(category_name: "Category3")
@category4 = Category.create(category_name: "Category4")
@category5 = Category.create(category_name: "Category5")

@interest1  = @category1.interests.create(interest_name: "interest1", description: "description1", image: "v1437647939/pgk1tslryt8vymvbejyo.png" , icon: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@interest2  = @category1.interests.create(interest_name: "interest2", description: "description2", image: "v1437647939/pgk1tslryt8vymvbejyo.png" , icon: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@interest3  = @category2.interests.create(interest_name: "interest3", description: "description3", image: "v1437647939/pgk1tslryt8vymvbejyo.png" , icon: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@interest4  = @category2.interests.create(interest_name: "interest4", description: "description4", image: "v1437647939/pgk1tslryt8vymvbejyo.png" , icon: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@interest5  = @category3.interests.create(interest_name: "interest5", description: "description5", image: "v1437647939/pgk1tslryt8vymvbejyo.png" , icon: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@interest6  = @category3.interests.create(interest_name: "interest6", description: "description6", image: "v1437647939/pgk1tslryt8vymvbejyo.png" , icon: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@interest7  = @category4.interests.create(interest_name: "interest7", description: "description7", image: "v1437647939/pgk1tslryt8vymvbejyo.png" , icon: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@interest8  = @category4.interests.create(interest_name: "interest8", description: "description8", image: "v1437647939/pgk1tslryt8vymvbejyo.png" , icon: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@interest9  = @category5.interests.create(interest_name: "interest9", description: "description9", image: "v1437647939/pgk1tslryt8vymvbejyo.png" , icon: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@interest10 = @category5.interests.create(interest_name: "interest10", description: "description10", image: "v1437647939/pgk1tslryt8vymvbejyo.png" , icon: "v1437647939/pgk1tslryt8vymvbejyo.png" )


@question1  = @category1.questions.create(question: "This is question 1?",interest_id: @interest2.id)
@question2  = @category1.questions.create(question: "This is question 2?",interest_id: @interest4.id)
@question3  = @category2.questions.create(question: "This is question 3?",interest_id: @interest2.id)
@question4  = @category2.questions.create(question: "This is question 4?",interest_id: @interest4.id)
@question5  = @category3.questions.create(question: "This is question 5?",interest_id: @interest10.id)
@question6  = @category3.questions.create(question: "This is question 6?",interest_id: @interest9.id)
@question7  = @category4.questions.create(question: "This is question 7?",interest_id: @interest4.id)
@question8  = @category4.questions.create(question: "This is question 8?",interest_id: @interest3.id)
@question9  = @category5.questions.create(question: "This is question 9?",interest_id: @interest4.id)
@question10 = @category5.questions.create(question: "This is question 10?",interest_id: @interest3.id)


@feedback1 = @user1.feedbacks.create(content: "content1")
@feedback2 = @user2.feedbacks.create(content: "content2")
@feedback3 = @user3.feedbacks.create(content: "content3")
@feedback4 = @user4.feedbacks.create(content: "content4")
@feedback5 = @user5.feedbacks.create(content: "content5")

@event1 = Event.create(event_name: "event1", place: "place1", city: "Ghaziabad",host_name: "Company name", image: "v1437647939/pgk1tslryt8vymvbejyo.png",link: "http://www.mobiloitte.com/",event_date: "2015-09-14",event_time: "5:00 PM" )
@event2 = Event.create(event_name: "event2", place: "place2", city: "New Delhi",host_name: "Company name", image: "v1437647939/pgk1tslryt8vymvbejyo.png",link: "http://www.mobiloitte.com/",event_date: "2015-09-16",event_time: "5:00 PM" )
@event3 = Event.create(event_name: "event3", place: "place3", city: "Rajnagar",host_name: "Company name", image: "v1437647939/pgk1tslryt8vymvbejyo.png",link: "http://www.mobiloitte.com/",event_date: "2015-09-20",event_time: "5:00 PM" )
@event4 = Event.create(event_name: "event4", place: "place4", city: "city4",host_name: "Company name", image: "v1437647939/pgk1tslryt8vymvbejyo.png",link: "http://www.mobiloitte.com/",event_date: "2015-09-21",event_time: "5:00 PM" )
@event5 = Event.create(event_name: "event5", place: "place5", city: "city5",host_name: "Company name", image: "v1437647939/pgk1tslryt8vymvbejyo.png",link: "http://www.mobiloitte.com/",event_date: "2015-09-22",event_time: "5:00 PM" )

@city1 = City.create(city_name: "Ghaziabad", state: "Uttar Pradesh", country: "India", status: false)
@city2 = City.create(city_name: "New Delhi", state: "Delhi", country: "India", status: false)
@city3 = City.create(city_name: "Rajnagar", state: "Bihar", country: "India", status: false)

@user1.interests << [@interest1,@interest3,@interest9]
@user2.interests << [@interest1,@interest4,@interest7] 
@user3.interests << [@interest2,@interest3,@interest1] 
@user4.interests << [@interest3,@interest10,@interest1] 
@user5.interests << [@interest6,@interest5,@interest7,@interest1] 

@invitation1 = @user1.invitations.create(:reciever => 2,:status => true)
@invitation2 = @user1.invitations.create(:reciever => 3,:status => true)
@invitation3 = @user1.invitations.create(:reciever => 4,:status => true)
@invitation4 = @user3.invitations.create(:reciever => 2,:status => true)
@invitation5 = @user3.invitations.create(:reciever => 5,:status => true)
@invitation7 = @user5.invitations.create(:reciever => 1,:status => true)
@invitation8 = @user5.invitations.create(:reciever => 2,:status => true)
@invitation9 = @user5.invitations.create(:reciever => 4,:status => true)

@service_point1  = ServicePoint.create(service: "Sign Up", point: 100)
@service_point2  = ServicePoint.create(service: "First Post to Newsfeed", point: 50)
@service_point3  = ServicePoint.create(service: "Send chat invite", point: 20)
@service_point4  = ServicePoint.create(service: "Accept Chat invite", point: 20)
@service_point5  = ServicePoint.create(service: "Reply first to ice breaker message", point: 20)
@service_point6  = ServicePoint.create(service: "Add more images to profile", point: 50)
@service_point7  = ServicePoint.create(service: "Add New City", point: 50)
@service_point8  = ServicePoint.create(service: "Rate Roammate", point: 50)
@service_point9  = ServicePoint.create(service: "Invite a Friend", point: 50)
@service_point10 = ServicePoint.create(service: "user ratings", point: 10)
@service_point11 = ServicePoint.create(service: "current location distance", point: 10)
@service_point12 = ServicePoint.create(service: "last activity", point: 10)
@service_point13 = ServicePoint.create(service: "last active", point: 10)
@service_point14 = ServicePoint.create(service: "age", point: 10)
@service_point15 = ServicePoint.create(service: "gender", point: 10)
@service_point16 = ServicePoint.create(service: "common activities", point: 10)
@service_point17 = ServicePoint.create(service: "common friends", point: 10)
@service_point18 = ServicePoint.create(service: "city lived in", point: 10)
@service_point19 = ServicePoint.create(service: "common cities", point: 10)


@points1 = @user1.points.create(pointable_type: "Sign Up")
@points2 = @user1.points.create(pointable_type: "First Post to Newsfeed")
@points3 = @user2.points.create(pointable_type: "Accept Chat invite")
@points4 = @user2.points.create(pointable_type: "Send chat invite")
@points5 = @user3.points.create(pointable_type: "Sign Up")
@points6 = @user3.points.create(pointable_type: "Reply first to ice breaker message")
@points7 = @user4.points.create(pointable_type: "First Post to Newsfeed")
@points8 = @user5.points.create(pointable_type: "Send chat invite")

@special_message1  = @interest1.special_messages.create(content: "this is demo message", status: false)
@special_message2  = @interest2.special_messages.create(content: "this is demo message", status: false)
@special_message3  = @interest3.special_messages.create(content: "this is demo message", status: false)
@special_message4  = @interest4.special_messages.create(content: "this is demo message", status: false)
@special_message5  = @interest5.special_messages.create(content: "this is demo message", status: false)
@special_message6  = @interest6.special_messages.create(content: "this is demo message", status: false)
@special_message7  = @interest7.special_messages.create(content: "this is demo message", status: false)
@special_message8  = @interest8.special_messages.create(content: "this is demo message", status: false)
@special_message9  = @interest9.special_messages.create(content: "this is demo message", status: false)
@special_message10 = @interest10.special_messages.create(content: "this is demo message", status: false)
@special_message11 = @interest4.special_messages.create(content: "this is demo message", status: false)
