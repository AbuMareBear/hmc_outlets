require 'spec_helper'

describe HmcOutlets do
  
  let(:certified_outlet_list) { ["outlet 1", "outlet 2", "outlet 4"] }
  let(:removed_outlets) { ["outlet 3", "outlet 5", "outlet 6"] }
  let(:non_existent_outlet) { "outlet 12" }
  
  
  specify {expect(HmcOutlets::VERSION).not_to be nil }
  specify { expect(HmcOutlets::CERTIFIED_OUTLETS_URI).to eq "http://www.halalhmc.org/certified-outlets-results.htm#result" }
  
  describe ".certified_outlet_list" do
    it "returns an array of all certified outlets" do
      expect(HmcOutlets.certified_outlet_list).to eq(certified_outlet_list)
    end
  end
  
  describe ".removed_outlets" do
    it "returns an array of all removed outlets" do
      expect(HmcOutlets.removed_outlets).to eq(removed_outlets)
    end
  end
  
  describe ".certified?(outlet_name)" do
    it "returns true for currently certified outlets" do
      expect(HmcOutlets.certified?(certified_outlet_list[0])).to be_truthy
    end
    it "returns false for outlets that have been removed" do
      expect(HmcOutlets.certified?(removed_outlets[0])).to be_falsey
    end
    it "returns false for non-existant outlets" do
      expect(HmcOutlets.certified?(non_existent_outlet)).to be_falsey
    end
  end
  
  describe ".revoked?(outlet_name)" do
    it "returns true if outlet has had their certificate revoked" do
      expect(HmcOutlets.revoked?(removed_outlets[0])).to be_truthy
    end 
    it "returns false for currently certified outlets" do
      expect(HmcOutlets.revoked?(certified_outlet_list[0])).to be_falsey
    end
    it "returns false for non-existant outlets" do
      expect(HmcOutlets.revoked?(non_existent_outlet)).to be_falsey
    end
  end
end
