require 'spec_helper'

describe HmcOutlets do
  
  let(:certified_outlet_list) { ["outlet 1", "outlet 2", "outlet 4"] }
  let(:revoked_outlet_list) { ["outlet 3", "outlet 5", "outlet 6"] }
  let(:non_existent_outlet) { "outlet 12" }
  let(:outlets) do 
    [ 
      { name: "outlet 1", phone: "phonenumber1", street: "address1", city: "city1", county: "county1", postcode: "postcode1", status: "certified" },
      { name: "outlet 2", phone: "phonenumber2", street: "address2", city: "city2", county: "county2", postcode: "postcode2", status: "certified" },
      { name: "outlet 3", phone: "phonenumber3", street: "address3", city: "city3", county: "county3", postcode: "postcode3", status: "revoked" },
      { name: "outlet 4", phone: "phonenumber4", street: "address4", city: "city4", county: "county4", postcode: "postcode4", status: "certified" },
      { name: "outlet 5", phone: "phonenumber5", street: "address5", city: "city5", county: "county5", postcode: "postcode5", status: "revoked" },
      { name: "outlet 6", phone: "phonenumber6", street: "address6", city: "city6", county: "county6", postcode: "postcode6", status: "revoked" }
    ]
  end
  let(:certified_outlets) do 
    [ 
      { name: "outlet 1", phone: "phonenumber1", street: "address1", city: "city1", county: "county1", postcode: "postcode1" },
      { name: "outlet 2", phone: "phonenumber2", street: "address2", city: "city2", county: "county2", postcode: "postcode2" },
      { name: "outlet 4", phone: "phonenumber4", street: "address4", city: "city4", county: "county4", postcode: "postcode4" }
    ]
  end
  let(:revoked_outlets) do 
    [ 
      { name: "outlet 3", phone: "phonenumber3", street: "address3", city: "city3", county: "county3", postcode: "postcode3" },
      { name: "outlet 5", phone: "phonenumber5", street: "address5", city: "city5", county: "county5", postcode: "postcode5" },
      { name: "outlet 6", phone: "phonenumber6", street: "address6", city: "city6", county: "county6", postcode: "postcode6" }
    ]
  end
  
  specify {expect(HmcOutlets::VERSION).not_to be nil }
  specify { expect(HmcOutlets::CERTIFIED_OUTLETS_URI).to eq "http://www.halalhmc.org/certified-outlets-results.htm#result" }
  
  describe ".outlets" do
    it "returns a hash with the name, telephone and address of all outlets (certified/revoked)" do
      expect(HmcOutlets.outlets).to eq(outlets)
    end
  end
  
  describe ".certified_outlets" do
    it "returns a hash with the name, telephone and address of certified outlets" do
      expect(HmcOutlets.certified_outlets).to eq(certified_outlets)
    end
  end
  
  describe ".revoked_outlets" do
    it "returns a hash with the name, telephone and address of revoked outlets" do
      expect(HmcOutlets.revoked_outlets).to eq(revoked_outlets)
    end
  end
  
  describe ".outlet_list" do
    it "returns an array of all outlets (certifed/revoked)" do
      expect(HmcOutlets.outlet_list).to eq((certified_outlet_list + revoked_outlet_list).sort)
    end
  end
  
  describe ".certified_outlet_list" do
    it "returns an array of all certified outlets" do
      expect(HmcOutlets.certified_outlet_list).to eq(certified_outlet_list)
    end
  end
  
  describe ".revoked_outlet_list" do
    it "returns an array of all revoked outlets" do
      expect(HmcOutlets.revoked_outlet_list).to eq(revoked_outlet_list)
    end
  end
  
  describe ".certified?(outlet_name)" do
    it "returns true for currently certified outlets" do
      expect(HmcOutlets.certified?(certified_outlet_list[0])).to be_truthy
    end
    it "returns false for outlets that have been removed" do
      expect(HmcOutlets.certified?(revoked_outlet_list[0])).to be_falsey
    end
    it "returns false for non-existant outlets" do
      expect(HmcOutlets.certified?(non_existent_outlet)).to be_falsey
    end
  end
  
  describe ".revoked?(outlet_name)" do
    it "returns true if outlet has had their certificate revoked" do
      expect(HmcOutlets.revoked?(revoked_outlet_list[0])).to be_truthy
    end 
    it "returns false for currently certified outlets" do
      expect(HmcOutlets.revoked?(certified_outlet_list[0])).to be_falsey
    end
    it "returns false for non-existant outlets" do
      expect(HmcOutlets.revoked?(non_existent_outlet)).to be_falsey
    end
  end
end
