require 'rails_helper'

RSpec.describe ProjectsHelper, type: :helper do
  describe "#status_color" do
    it "returns the correct color classes for draft status" do
      expect(helper.status_color("Draft")).to eq("bg-gray-200 text-gray-800 border border-gray-300")
    end

    it "returns the correct color classes for in progress status" do
      expect(helper.status_color("In Progress")).to eq("bg-blue-100 text-blue-800 border border-blue-300")
    end

    it "returns the correct color classes for blocked status" do
      expect(helper.status_color("Blocked")).to eq("bg-red-100 text-red-800 border border-red-300")
    end

    it "returns the correct color classes for completed status" do
      expect(helper.status_color("Completed")).to eq("bg-green-100 text-green-800 border border-green-300")
    end

    it "returns the default color classes for unknown status" do
      expect(helper.status_color("Unknown")).to eq("bg-gray-200 text-gray-800 border border-gray-300")
    end
  end
end
