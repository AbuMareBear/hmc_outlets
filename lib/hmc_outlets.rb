require "hmc_outlets/version"
require "open-uri"
require "nokogiri"

module HmcOutlets
  CERTIFIED_OUTLETS_URI = "http://www.halalhmc.org/certified-outlets-results.htm#result"
  
  def self.certified?(outlet_name)
    certified_outlet_list.include?(outlet_name)
  end
  
  def self.revoked?(outlet_name)
    removed_outlets.include?(outlet_name)
  end
  
  def self.certified_outlet_list
    @certified_outlets ||= outlets_page.css('table.outlettable tr td:not(.removed) strong').map { |name| name.text.gsub(/[[:space:]]$/, '') }
  end
  
  def self.removed_outlets
    @removed_outlets ||= outlets_page.css('table.outlettable tr td.removed strong').map { |name| name.text.gsub(/[[:space:]]$/, '') }
  end
  
  private
  
    def self.outlets_page
      @outlets_page ||= Nokogiri::HTML(open(CERTIFIED_OUTLETS_URI))
    end
end
