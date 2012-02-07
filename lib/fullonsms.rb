class FullOnSms < SmsProvider
  attr_accessor :message
  attr_accessor :receiver_no
  FULLONSMS = "http://site5.way2sms.com".freeze
  REGEX = /http:\/\/site5.way2sms.com\/(.+)/.freeze
  
  ## Various Restriction that Provider enforce
  def restriction
  end
  
  def send
  end
  
  private
  
  def header
  end
end
