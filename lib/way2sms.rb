require "net/http"
require "net/https"
require "uri"
require "cgi"
class Way2Sms < SmsProvider
  attr_accessor :message
  attr_accessor :receiver_no
  WAY2SMS = ("http://site%s.way2sms.com" % (rand(7) + 1)).freeze
  REGEX = /http:\/\/site\d.way2sms.com\/(.+)/.freeze
  BPATH = "/content/index.html"
  LPATH = 
  MPATH = '/FirstServletsms?custid='
  APATH = '%s'
  attr_reader :restriction
  attr_accessor :http
  attr_reader :logged_in
  def initialize(username=nil,password=nil)
    @cookie_jars = {}
    
    @cookie_jars.default = nil
    @restriction = 160
    super(username,password)
    initialize_net_http
    make_a_trip LPATH,@cookie_jars
    @logged_in = false
  end
  ## Various Restriction that Provider enforce
  def restrict_msg_size
    if message.length > restriction
      message = message[0...restriction]
    end
    return message       
  end
 
  
  def send
    unless @logged_in 
      login
      @loggen_in = true
    end
    deliver_message   
  end

  
  def http
    @http
  end
  
  private

  def initialize_net_http
    @http = Net::HTTP.new parse.host,parse.port
    ssl_certificate
  end


  def parse
    URI.parse WAY2SMS
  end

  def ssl_certificate
    if is_ssl?
       http.use_ssl = true
       http.ca_path = "/etc/ssl/certs"
       http.verify_mode = OpenSSL::SSL::VERIFY_PEER  
     end
  end
  
  def is_ssl?
    WAY2SMS =~ /https/ 
  end
  
  def make_a_trip path=BPATH,cookie={}
    response = http.get path,cookie
    extract_cookie response   
  end

  def extract_cookie response
    identify_response response
  end  

  def identify_response response
    switch response.code
      case 200
        set_cookie_jar(response)
      case 302
        make_a_trip identify_redirection(response),set_cookie_jar(response)
      case 400
         break
      else
         break 
      end           
  end

  def identify_redirection response
    response['Location']
  end

  def set_cookie_jar(response)
    @cookie_jars = response['set-cookie']
  end

  def login
    extract_cookie http.post LPATH ,header(BPATH,BPATH)
  end

  def deliver_message
'custid=undefined&HiddenAction=instantsms&Action=hgfgh5656fgd&login=&pass=&MobNo='+receiver_no+'&textArea='+ restrict_message_size(message)
  
   extract_cookie http.post(MPATH,header(APATH,APATH))
  end
    
  def header PATH,REFERER
    {"Cookie" => @cookie_jars[PATH],"Referer" => REFERER,"Content-Type" => "application/x-www-form-urlencoded" , "User-Agent" => "Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.3) Gecko/20091020 Ubuntu/9.10 (karmic) Firefox/3.5.3 GTB7.0" }
  end
   
   
end

