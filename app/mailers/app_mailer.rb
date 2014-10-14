class AppMailer < ActionMailer::Base
  default from: "mr.zaur22@gmail.com"
  
  def welcome_email(user)
   @user = user
   mail(to: "zaur9422@mail.ru", 
   		subject: "Заказ #{@user.id}")
  end

end