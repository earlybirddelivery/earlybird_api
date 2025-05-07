module SpringEdge
  class Messages
    def self.send_otp(otp, to_number)
      message = "#{otp} is the One-time Password (OTP) to complete your transaction. Please do not share this with anyone - Universal Healthy products."
      mobileno = "91#{to_number}"
      senderid = ENV['SMS_SENDER_ID']
      apikey = ENV['SPRINGEDGE_API_KEY']

      baseurl = "https://instantalerts.co/api/web/send/?apikey=#{apikey}&sender=#{senderid}"

      url = URI(baseurl + '&to=' + mobileno + '&message=' + message + '&formt=' + 'json')
      res = Net::HTTP.get_response(url)
    end
  end
end
