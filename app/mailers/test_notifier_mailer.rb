class TestNotifierMailer < ApplicationMailer
    default :from => 'smartparkingsjsu@gmail.com'
    
    # send a signup email to the user, pass in the user object that   contains the user's email address
    def test_booking_reminder(user)
        @user = user
        mail(   :to => @user.email,
                :subject => "Hello World Email" )
    end    

    def test_text_reminder(user)
        @user = user
        mail(   :to => @user.email,
                :subject => "Hello World Text" )
    end    
end