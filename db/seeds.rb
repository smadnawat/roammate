# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@admin_user = AdminUser.create(email: "admin@example.com", password: "password")

@user1 = User.create(provider: "facebook", user_id: "11111")
@user2 = User.create(provider: "facebook", user_id: "22222")
@user3 = User.create(provider: "facebook", user_id: "33333")
@user4 = User.create(provider: "facebook", user_id: "44444")
@user5 = User.create(provider: "facebook", user_id: "55555")

@profile1 = Profile.create(email: "#{@user1.user_id}@facebook.com", fb_email: "user1@domain.com",first_name: "ABCD", image: "v1437647939/pgk1tslryt8vymvbejyo.png" ,last_name: "Aab", gender: "male", status: false, user_id: @user1.id,dob: "1997-07-16",location: "Demo location",current_city: "Delhi")
@profile2 = Profile.create(email: "#{@user2.user_id}@facebook.com", fb_email: "user2@domain.com",first_name: "EFGH", image: "v1437647939/pgk1tslryt8vymvbejyo.png" ,last_name: "Eef", gender: "male", status: false, user_id: @user2.id,dob: "1996-07-16",location: "Demo location",current_city: "Delhi")
@profile3 = Profile.create(email: "#{@user3.user_id}@facebook.com", fb_email: "user3@domain.com",first_name: "IJKL", image: "v1437647939/pgk1tslryt8vymvbejyo.png" ,last_name: "Iij", gender: "male", status: false, user_id: @user3.id,dob: "1992-07-16",location: "Demo location",current_city: "Delhi")
@profile4 = Profile.create(email: "#{@user4.user_id}@facebook.com", fb_email: "user4@domain.com",first_name: "MNOP", image: "v1437647939/pgk1tslryt8vymvbejyo.png" ,last_name: "Mmn", gender: "male", status: false, user_id: @user4.id,dob: "1990-07-16",location: "Demo location",current_city: "Delhi")
@profile5 = Profile.create(email: "#{@user5.user_id}@facebook.com", fb_email: "user5@domain.com",first_name: "QRST", image: "v1437647939/pgk1tslryt8vymvbejyo.png" ,last_name: "Qqr", gender: "male", status: false, user_id: @user5.id,dob: "1995-07-16",location: "Demo location",current_city: "Delhi")

@rating1 = @user1.ratings.create(rate: "0", rater_id: @user2.id)
@rating2 = @user2.ratings.create(rate: "1", rater_id: @user1.id)
@rating3 = @user3.ratings.create(rate: "-1", rater_id: @user4.id, reason: "abusive/inappropriate language")
@rating4 = @user4.ratings.create(rate: "-1", rater_id: @user3.id, reason: "abusive/inappropriate language")
@rating5 = @user5.ratings.create(rate: "1", rater_id: @user2.id)

@message1 = @user1.messages.create(reciever: @user2.id, content: "message1")
@message2 = @user1.messages.create(reciever: @user3.id, content: "message2")
@message3 = @user2.messages.create(reciever: @user3.id, content: "message3")
@message4 = @user2.messages.create(reciever: @user5.id, content: "message4")
@message5 = @user3.messages.create(reciever: @user4.id, content: "message5")
@message6 = @user3.messages.create(reciever: @user1.id, content: "message6")
@message7 = @user4.messages.create(reciever: @user3.id, content: "message7")
@message8 = @user4.messages.create(reciever: @user5.id, content: "message8")
@message9 = @user5.messages.create(reciever: @user2.id, content: "message9")
@message10 = @user5.messages.create(reciever: @user4.id, content: "message10")

@post1 = @user1.posts.create(title: "post1", content: "content1",user_type: "user", image: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@post2 = @user2.posts.create(title: "post2", content: "content2",user_type: "user", image: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@post3 = @user3.posts.create(title: "post3", content: "content3",user_type: "user", image: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@post4 = @user4.posts.create(title: "post4", content: "content4",user_type: "user", image: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@post5 = @user5.posts.create(title: "post5", content: "content5",user_type: "user", image: "v1437647939/pgk1tslryt8vymvbejyo.png" )

@comment1 = @post1.comments.create(reply: "Hello",user_id: @user1.id  )
@comment2 = @post1.comments.create(reply: "Hii",user_id: @user2.id )
@comment3 = @post2.comments.create(reply: "Hello",user_id: @user1.id )
@comment4 = @post2.comments.create(reply: "Hii",user_id: @user2.id )
@comment5 = @post3.comments.create(reply: "Hello",user_id: @user3.id )
@comment6 = @post3.comments.create(reply: "Hii",user_id: @user4.id )
@comment7 = @post4.comments.create(reply: "Hello",user_id: @user3.id )
@comment8 = @post4.comments.create(reply: "Hii",user_id: @user5.id )
@comment9 = @post5.comments.create(reply: "Hii",user_id: @user4.id )
@comment10 = @post5.comments.create(reply: "Hello",user_id: @user5.id )

@category1 = Category.create(category_name: "Category1")
@category2 = Category.create(category_name: "Category2")
@category3 = Category.create(category_name: "Category3")
@category4 = Category.create(category_name: "Category4")
@category5 = Category.create(category_name: "Category5")

@interest1 = @category1.interests.create(interest_name: "interest1", description: "description1", image: "v1437647939/pgk1tslryt8vymvbejyo.png" , icon: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@interest2 = @category1.interests.create(interest_name: "interest2", description: "description2", image: "v1437647939/pgk1tslryt8vymvbejyo.png" , icon: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@interest3 = @category2.interests.create(interest_name: "interest3", description: "description3", image: "v1437647939/pgk1tslryt8vymvbejyo.png" , icon: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@interest4 = @category2.interests.create(interest_name: "interest4", description: "description4", image: "v1437647939/pgk1tslryt8vymvbejyo.png" , icon: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@interest5 = @category3.interests.create(interest_name: "interest5", description: "description5", image: "v1437647939/pgk1tslryt8vymvbejyo.png" , icon: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@interest6 = @category3.interests.create(interest_name: "interest6", description: "description6", image: "v1437647939/pgk1tslryt8vymvbejyo.png" , icon: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@interest7 = @category4.interests.create(interest_name: "interest7", description: "description7", image: "v1437647939/pgk1tslryt8vymvbejyo.png" , icon: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@interest8 = @category4.interests.create(interest_name: "interest8", description: "description8", image: "v1437647939/pgk1tslryt8vymvbejyo.png" , icon: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@interest9 = @category5.interests.create(interest_name: "interest9", description: "description9", image: "v1437647939/pgk1tslryt8vymvbejyo.png" , icon: "v1437647939/pgk1tslryt8vymvbejyo.png" )
@interest10 = @category5.interests.create(interest_name: "interest10", description: "description10", image: "v1437647939/pgk1tslryt8vymvbejyo.png" , icon: "v1437647939/pgk1tslryt8vymvbejyo.png" )


@question1 = @category1.questions.create(question: "This is question 1?",interest_id: @interest2.id)
@question2 = @category1.questions.create(question: "This is question 2?",interest_id: @interest4.id)
@question3 = @category2.questions.create(question: "This is question 3?",interest_id: @interest2.id)
@question4 = @category2.questions.create(question: "This is question 4?",interest_id: @interest4.id)
@question5 = @category3.questions.create(question: "This is question 5?",interest_id: @interest10.id)
@question6 = @category3.questions.create(question: "This is question 6?",interest_id: @interest9.id)
@question7 = @category4.questions.create(question: "This is question 7?",interest_id: @interest4.id)
@question8 = @category4.questions.create(question: "This is question 8?",interest_id: @interest3.id)
@question9 = @category5.questions.create(question: "This is question 9?",interest_id: @interest4.id)
@question10 = @category5.questions.create(question: "This is question 10?",interest_id: @interest3.id)


@feedback1 = @user1.feedbacks.create(content: "content1")
@feedback2 = @user2.feedbacks.create(content: "content2")
@feedback3 = @user3.feedbacks.create(content: "content3")
@feedback4 = @user4.feedbacks.create(content: "content4")
@feedback5 = @user5.feedbacks.create(content: "content5")

@event1 = Event.create(event_name: "event1", place: "place1", city: "city1",host_name: "Company name", image: "v1437647939/pgk1tslryt8vymvbejyo.png",link: "http://www.mobiloitte.com/",event_date: "2015-09-14",event_time: "5:00 PM" )
@event2 = Event.create(event_name: "event2", place: "place2", city: "city2",host_name: "Company name", image: "v1437647939/pgk1tslryt8vymvbejyo.png",link: "http://www.mobiloitte.com/",event_date: "2015-09-16",event_time: "5:00 PM" )
@event3 = Event.create(event_name: "event3", place: "place3", city: "city3",host_name: "Company name", image: "v1437647939/pgk1tslryt8vymvbejyo.png",link: "http://www.mobiloitte.com/",event_date: "2015-09-20",event_time: "5:00 PM" )
@event4 = Event.create(event_name: "event4", place: "place4", city: "city4",host_name: "Company name", image: "v1437647939/pgk1tslryt8vymvbejyo.png",link: "http://www.mobiloitte.com/",event_date: "2015-09-21",event_time: "5:00 PM" )
@event5 = Event.create(event_name: "event5", place: "place5", city: "city5",host_name: "Company name", image: "v1437647939/pgk1tslryt8vymvbejyo.png",link: "http://www.mobiloitte.com/",event_date: "2015-09-22",event_time: "5:00 PM" )

@city1 = City.create(city_name: "city1", state: "state1", country: "country1", status: false)
@city2 = City.create(city_name: "city2", state: "state2", country: "country2", status: false)
@city3 = City.create(city_name: "city3", state: "state3", country: "country3", status: false)
@city4 = City.create(city_name: "city4", state: "state4", country: "country4", status: false)
@city5 = City.create(city_name: "city5", state: "state5", country: "country5", status: false)

@points1 = @user1.points.create(pointable_type: "interest")
@points2 = @user1.points.create(pointable_type: "signup")
@points3 = @user2.points.create(pointable_type: "chat")
@points4 = @user2.points.create(pointable_type: "send invitation")
@points5 = @user3.points.create(pointable_type: "share")
@points6 = @user3.points.create(pointable_type: "signup")
@points7 = @user4.points.create(pointable_type: "share")
@points8 = @user5.points.create(pointable_type: "feedback")


@service_point1 = ServicePoint.create(service: "signup", point: 500)
@service_point2 = ServicePoint.create(service: "chat", point: 300)
@service_point3 = ServicePoint.create(service: "send invitation", point: 100)
@service_point4 = ServicePoint.create(service: "recieve invitation", point: 100)
@service_point5 = ServicePoint.create(service: "feedback", point: 200)
@service_point6 = ServicePoint.create(service: "first City", point: 100)
@service_point7 = ServicePoint.create(service: "rate", point: 300)
@service_point8 = ServicePoint.create(service: "interest", point: 200)
@service_point9 = ServicePoint.create(service: "post", point: 100)
@service_point10 = ServicePoint.create(service: "share", point: 500)