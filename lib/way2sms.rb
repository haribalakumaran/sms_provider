require "net/http"
require "uri"
class Way2Sms < SmsProvider
  attr_accessor :message
  attr_accessor :receiver_no
  WAY2SMS = ("http://site%s.way2sms.com" % (rand(7) + 1)).freeze
  REGEX = /http:\/\/site\d.way2sms.com\/(.+)/.freeze
  
  ## Various Restriction that Provider enforce
  def restriction   
  end
 
  
  def send
  end
  
  
  private
  
  def header
  end
   
   
end

