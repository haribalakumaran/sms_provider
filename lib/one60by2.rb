class One60by2 < SmsProvider
  attr_accessor :message
  attr_accessor :receiver_no
  ONE60BY2 = "http://site5.way2sms.com".freeze
  REGEX = /http:\/\/site5.way2sms.com\/(.+)/.freeze
 
  ## Various Restriction that Provider enforce 
  def restriction   
  end
  
 
  def send
  end

  
  
  private

  ## Some Provide require Cookie for login that why make a trip to the base domain to get cookie
  def make_a_trip
  end
  
  def header
    
  end
   
end
