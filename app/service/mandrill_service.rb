require 'mandrill'
class MandrillService
  
  def initialize api_key=ENV['MANDRILL_API_KEY']
    @mandrill = Mandrill::API.new ENV["MANDRILL_API_KEY"]
  end  
end  