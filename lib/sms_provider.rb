require "cookiejar"
class SmsProvider
  attr_accessor :username
  attr_writer :password
  
  def initialize(username=nil,password=nil)
    @username = username
    @password = password
  end
  
  def restriction
    raise "Attempt to call a method that shouldn't have been called ."
  end
  
  def password
    raise "Password cannot be viewed."
  end
end


autoload :Way2Sms , "/way2sms.rb"
autoload :One60by2, "/one60by2.rb"
autoload :FullOnSms , "/fullonsms.rb"



