require 'rails_helper'

RSpec.describe ProjectEvent, type: :model do
  let(:user) { User.create!(name: 'Test User', email: 'test@example.com', password: 'password123', role: 'member') }
  let(:project) { Project.create!(title: 'Test Project', description: 'Test Description', status: 'Draft') }
  
  describe "validations" do
    it "is valid with valid attributes for a comment" do
      event = ProjectEvent.new(
        user: user,
        project: project,
        event_type: 'comment',
        content: 'This is a comment'
      )
      expect(event).to be_valid
    end
    
    it "is valid with valid attributes for a status change" do
      event = ProjectEvent.new(
        user: user,
        project: project,
        event_type: 'status_change',
        previous_status: 'Draft',
        new_status: 'In Progress'
      )
      expect(event).to be_valid
    end
    
    it "is invalid without content for a comment" do
      event = ProjectEvent.new(
        user: user,
        project: project,
        event_type: 'comment',
        content: nil
      )
      expect(event).not_to be_valid
      expect(event.errors[:content]).to include("can't be blank")
    end
    
    it "is invalid without previous_status for a status change" do
      event = ProjectEvent.new(
        user: user,
        project: project,
        event_type: 'status_change',
        previous_status: nil,
        new_status: 'In Progress'
      )
      expect(event).not_to be_valid
      expect(event.errors[:previous_status]).to include("can't be blank")
    end
    
    it "is invalid without new_status for a status change" do
      event = ProjectEvent.new(
        user: user,
        project: project,
        event_type: 'status_change',
        previous_status: 'Draft',
        new_status: nil
      )
      expect(event).not_to be_valid
      expect(event.errors[:new_status]).to include("can't be blank")
    end
  end
  
  describe "associations" do
    it "belongs to a user" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end
    
    it "belongs to a project" do
      association = described_class.reflect_on_association(:project)
      expect(association.macro).to eq :belongs_to
    end
  end
  
  describe "methods" do
    it "returns the author name" do
      event = ProjectEvent.create!(
        user: user,
        project: project,
        event_type: 'comment',
        content: 'This is a comment'
      )
      expect(event.author_name).to eq user.name
    end
  end
end
