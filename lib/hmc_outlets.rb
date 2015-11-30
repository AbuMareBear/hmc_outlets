require "hmc_outlets/version"
require "open-uri"
require "nokogiri"

module HmcOutlets
  CERTIFIED_OUTLETS_URI = "http://www.halalhmc.org/certified-outlets-results.htm#result"
  
  def self.certified?(outlet_name)
    certified_outlet_list.include?(outlet_name)
  end
  
  def self.revoked?(outlet_name)
    revoked_outlet_list.include?(outlet_name)
  end
  
  def self.outlet_list
    @outlet_list ||= outlets.map { |o| o[:name] }
  end
  
  def self.certified_outlet_list
    @certified_outlet_list ||= certified_outlets.map { |o| o[:name] }
  end
  
  def self.revoked_outlet_list
    @removed_outlets ||= revoked_outlets.map { |o| o[:name] }
  end
  
  def self.outlets
    unless @outlets
      @outlets = Array.new
      outlets_page.css('table.outlettable tr').each do |o|
        if o.css('strong').size > 0 # if the table row has no strong element it means that it is not an outlet row.
          address = o.at_css('td[4]').text.gsub(/\t|,/, '').split("\n")
          @outlets << {
            name: o.at_css('strong').text.gsub(/[[:space:]]$/, ''),
            phone: o.at_css('.tel').text.gsub(/[[:space:]]$/, ''),
            street: address[0],
            city: address[1],
            county: address[2],
            postcode: address[3],
            status: o.css('td.removed').size == 0 ? "certified" : "revoked"
          }
        end
      end
    end
    @outlets
  end
  
  def self.certified_outlets
    @certified_outlets ||= outlets.select { |o| o[:status] == 'certified' }
  end
  
  def self.revoked_outlets
    @revoked_outlets ||= outlets.select { |o| o[:status] == 'revoked' }
  end
  
  private
  
    def self.outlets_page
      @outlets_page ||= Nokogiri::HTML(open(CERTIFIED_OUTLETS_URI))
    end
end
