require 'rails_helper'

RSpec.describe User, type: :model do
  # Factory validity
  it "has a valid factory" do
    expect(build(:user)).to be_valid
    expect(build(:user, :admin)).to be_valid
    expect(build(:user, :pm)).to be_valid
  end

  # Associations
  describe "associations" do
    it { is_expected.to have_many(:project_events).dependent(:destroy) }
  end

  # Validations
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:password) }
  end

  # Enums
  describe "enums" do
    it { is_expected.to define_enum_for(:role).with_values(member: "member", pm: "pm", admin: "admin").backed_by_column_of_type(:string) }
  end

  # Methods and business logic
  describe "role checks" do
    let(:admin) { build(:user, :admin) }
    let(:pm) { build(:user, :pm) }
    let(:member) { build(:user) }

    it "identifies admin role correctly" do
      expect(admin.admin?).to be true
      expect(pm.admin?).to be false
      expect(member.admin?).to be false
    end

    it "identifies pm role correctly" do
      expect(admin.pm?).to be false
      expect(pm.pm?).to be true
      expect(member.pm?).to be false
    end

    it "identifies member role correctly" do
      expect(admin.member?).to be false
      expect(pm.member?).to be false
      expect(member.member?).to be true
    end
  end
end
