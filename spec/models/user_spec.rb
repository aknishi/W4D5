# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) {  User.create!(username: 'test', password: '123456')}
  
  describe 'validations' do
  
    
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }
    
    it "creates password digest when a password is given" do
      expect(user.password_digest).to_not be_nil
    end
    
    it "creates a session token before validation" do
      expect(user.session_token).to_not be_nil
    end
    
    it "does not save password to the database" do
      expect(user.password).to_not be("123456")
    end
    
    it "encrypts password using BCrypt" do
      expect(BCrypt::Password).to receive(:create).with('123456')
      User.new(username: 'test', password: '123456')
    end
    
  end
  
  describe '#is_password?' do
    before(:each) do 
      user = User.create!(username: 'test', password: '123456')
      
      it 'checks that passwords match' do
        expect(user.is_password?('123456')).to be true
      end
      
      it 'checks that passwords don\'t match' do
        expect(user.is_password?('654321')).to be false
      end
    end
  end
  
  # describe 'self.find_by_credentials' do
  #   expect(User.find_by_credentials('test', 123546)).to eq(user)
  # end
  
  describe '#reset_session_token!' do
    before(:each) do 
      user = User.create!(username: 'test', password: '123456')
      old_session_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).not_to eq(old_session_token)
    end
  end
  
end
