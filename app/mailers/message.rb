class Message < ActionMailer::Base
#  default :from => "matt@bumptiousmusic.com"
  def message_us(data)
=begin
    @content = data
    mail(:from => 'matt@bumptiousmusic.com', 
         :to => 'matt@bumptiousmusic.com',
         :reply => data[:email],
         :subject => "A fan sent you a message")
=end
    @content = data
    mail( to: 'matthewcarrk@gmail.com',
          from:       "noreply@thegospelite.com",
          subject:    "A fan sent you a message")
          
  end

  def unlocked(data)
     @content = data
     mail(to:   'matthewcarrk@gmail.com',
          from: "noreply@thegospelite.com",
          subject: "Five tracks have been unlocked")
  end
end
