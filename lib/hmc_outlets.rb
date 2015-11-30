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
    @outlet_list ||= outlets_page.css('table.outlettable tr td strong').map { |name| name.text.gsub(/[[:space:]]$/, '') }
  end
  
  def self.certified_outlet_list
    @certified_outlet_list ||= outlets_page.css('table.outlettable tr td:not(.removed) strong').map { |name| name.text.gsub(/[[:space:]]$/, '') }
  end
  
  def self.revoked_outlet_list
    @removed_outlets ||= outlets_page.css('table.outlettable tr td.removed strong').map { |name| name.text.gsub(/[[:space:]]$/, '') }
  end
  
  def self.outlets
    unless @outlets
      @outlets = Array.new
      outlets = outlets_page.css('table.outlettable tr')
      outlets.each do |o|
        if o.css('strong').size > 0
          name = o.css('strong').map { |n| n.text.gsub(/[[:space:]]$/, '') }
          phone = o.css('.tel').map { |n| n.text.gsub(/[[:space:]]$/, '') }
          address = o.css('td[4]').map do |n| 
            text = n.text
            text.gsub!(/\t/, '')
            text.gsub!(/,/, '')
            text.split("\n")
          end
          street = address[0][0] if address[0]
          city = address[0][1] if address[0]
          county = address[0][2] if address[0]
          postcode = address[0][3] if address[0]
          status = o.css('td.removed').size == 0 ? "certified" : "revoked"
          @outlets << { name: name[0], phone: phone[0], street: street, city: city, county: county, postcode: postcode, status: status }
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
