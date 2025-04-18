require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      project = described_class.new(
        title: 'Test Project',
        description: 'Test Description',
        status: 'Draft'
      )
      expect(project).to be_valid
    end

    it "is not valid without a title" do
      project = described_class.new(
        title: nil,
        description: 'Test Description',
        status: 'Draft'
      )
      expect(project).not_to be_valid
      expect(project.errors[:title]).to include("can't be blank")
    end

    it "requires a status" do
      # Test the validation presence directly
      validator = described_class.validators_on(:status).find { |v| v.is_a?(ActiveRecord::Validations::PresenceValidator) }
      expect(validator).to be_present
    end

    it "is not valid with an invalid status" do
      project = described_class.new(
        title: 'Test Project',
        description: 'Test Description',
        status: 'Invalid Status'
      )
      expect(project).not_to be_valid
      expect(project.errors[:status]).to include("is not included in the list")
    end
  end

  describe "associations" do
    it "has many project events" do
      association = described_class.reflect_on_association(:project_events)
      expect(association.macro).to eq :has_many
    end
  end

  describe "defaults" do
    it "sets status to Draft by default" do
      project = described_class.new(title: 'Test Project')
      expect(project.status).to eq 'Draft'
    end
  end

  describe "constants" do
    it "defines valid statuses" do
      expect(described_class::STATUSES).to eq [ "Draft", "In Progress", "Blocked", "Completed" ]
    end
  end
end
