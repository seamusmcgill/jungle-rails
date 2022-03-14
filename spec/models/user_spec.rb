require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    subject do 
      @user = User.new(name: 'Joe Blow', email: 'joeblow@gmail.com', password: 'password', password_confirmation: 'password')
    end
    it 'should save a user when all fields are entered properly' do
      subject.save
      expect(subject).to be_valid
    end
    it 'should not save a user when a name is not entered' do
      subject.name = nil
      subject.save 
      expect(subject.errors.full_messages).to include("Name can't be blank")
    end
    it 'should not save a user when an email is not entered' do 
      subject.email = nil
      subject.save
      expect(subject.errors.full_messages).to include("Email can't be blank")
    end
    it 'should not save a user when a repeat email is entered' do
      subject.save
      @user_two = User.new(name: 'Joseph Blow', email: 'JOEBLOW@GMAIL.COM', password: 'PASSWORD', password_confirmation: 'PASSWORD')
      @user_two.save
      expect(@user_two.errors.full_messages).to include("Email has already been taken")
    end
    it 'should not save a user when a password is not entered' do
      subject.password = nil
      subject.save
      expect(subject.errors.full_messages).to include("Password can't be blank")
    end
    it 'should not save a user when a password confirmation is not entered' do
      subject.password_confirmation = nil
      subject.save
      expect(subject.errors.full_messages).to include("Password confirmation can't be blank")
    end
    it 'should not save a user when their passwords do not match' do
      subject.password_confirmation = 'PASSWORD'
      subject.save
      expect(subject.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'should not save a user when their password is too short' do
      subject.password = 'pass'
      subject.password_confirmation = 'pass'
      subject.save
      expect(subject.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end
  describe '.authenticate_with_credentials' do
    # examples for this class method here
    subject do 
      @user = User.new(name: 'Joe Blow', email: 'joeblow@gmail.com', password: 'password', password_confirmation: 'password')
    end
    it 'should authenticate a user when they exist in the database' do
      subject.save
      @session_user = User.authenticate_with_credentials('joeblow@gmail.com', 'password')
      expect(@session_user.name).to eq('Joe Blow')
    end
    it 'should authenticate a user who exists with trailing spaces in their email' do
      subject.save
      @session_user = User.authenticate_with_credentials('  joeblow@gmail.com  ', 'password')
      expect(@session_user.name).to eq('Joe Blow')
    end
    it 'should authenticate a user who enters their email in mismatched case' do
      subject.save
      @session_user = User.authenticate_with_credentials('JoEbLoW@GMAIL.com', 'password')
      expect(@session_user.name).to eq('Joe Blow')
    end
    it 'should not authenticate a user when they exist but enter the wrong password' do
      subject.save
      @session_user = User.authenticate_with_credentials('joeblow@gmail.com', 'PASSWORD')
      expect(@session_user).to be_nil
    end
    it 'should not authenticate a user when they do not exist in the database' do
      @session_user = User.authenticate_with_credentials('bigdog@gmail.com', 'password')
      expect(@session_user).to be_nil
    end
  end
end
