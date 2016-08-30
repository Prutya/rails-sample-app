require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validation" do
    let(:user) { FactoryGirl.build :user }

    it "when user is valid" do
      expect(user).to be_valid
    end

    it "when email is valid" do
      valid_emails = ["user@example.com",
                      "USER@example.com",
                      "A_USER@example.com",
                      "user.user@example.com",
                      "user+user@example.com"]

      valid_emails.each do |valid_email|
        user.email = valid_email
        expect(user).to be_valid
      end
    end

    it "when first name is too long" do
      user.first_name = 'a' * 100

      expect(user).not_to be_valid
    end

    it "when last name is too long" do
      user.last_name = 'a' * 100

      expect(user).not_to be_valid
    end

    it "when email is too long" do
      user.email = 'a' * 300

      expect(user).not_to be_valid
    end

    it "when email is not valid" do
      invalid_emails = ["user@example,com",
                        "user_at_example.com",
                        "user.user@example.",
                        "user@example_example.com",
                        "user@example+example.com",
                        "user@example..com"]

      invalid_emails.each do |invalid_email|
        user.email = invalid_email
        expect(user).not_to be_valid
      end
    end

    it "when other user's email is same but it's case is different" do
      other_user = user.dup
      other_user.email.upcase!
      user.save

      save_result = other_user.save

      expect(save_result).to eq(false)
    end
  end
end
