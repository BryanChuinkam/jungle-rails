require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validation' do

    it 'should save successfully when all required fields are properly set' do
      @user = User.new(first_name: 'Bryan', last_name: 'Cranston', email: 'bryan@gmail.com', password: "123456789", password_confirmation: "123456789")
      expect(@user).to be_valid
    end

    it 'should fail and show error message if password and password_confirmation do not match' do
      @user = User.new(first_name: 'Bryan', last_name: 'Cranston', email: 'bryan@gmail.com', password: "123456789", password_confirmation: "987654321")
      @user.save 
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should fail and show error message if password not set' do
      @user = User.new(first_name: 'Bryan', last_name: 'Cranston', email: 'bryan@gmail.com', password: nil, password_confirmation: nil)
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should fail and show error message if first_name is not set' do
      @user = User.new(first_name: nil, last_name: 'Cranston', email: 'bryan@gmail.com', password: "123456789", password_confirmation: "123456789")
      @user.save
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'should fail and show error message if last_name is not set' do
      @user = User.new(first_name: 'Bryan', last_name: nil, email: 'bryan@gmail.com', password: "123456789", password_confirmation: "123456789")
      @user.save
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'should fail and show error message if email not set' do
      @user = User.new(first_name: 'Bryan ', last_name: 'Cranston', email: nil, password: "123456789", password_confirmation: "123456789")
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should fail and show error message if email is not unique' do
      @user_1 = User.new(first_name: 'Bryan', last_name: 'Cranston',  email: 'bryan@gmail.com', password: "123456789", password_confirmation: "123456789")
      @user_1.save
      @user_2 = User.new(first_name: 'Bryan', last_name: 'Adams',  email: 'BRYAN@gmail.com', password: "987654321", password_confirmation: "987654321")
      @user_2.save
      expect(@user_2.errors.full_messages).to include("Email has already been taken")
    end

    it 'should fail and show error message if password does not meet minimun password length requirement' do
      @user = User.new(first_name: 'Bryan', last_name: 'Cranston',  email: 'bryan@gmail.com', password:"123", password_confirmation: "123")
      @user.save
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 7 characters)')
    end
    

  end

  describe '.authenticate_with_credentials' do
    
    it 'should successfully log user in with valid credentials' do
      @user = User.new(first_name: 'Bryan', last_name: 'Cranston', email: 'bryan@gmail.com', password: "123456789", password_confirmation: "123456789")
      @user.save
      @user_logged_in = User.authenticate_with_credentials('bryan@gmail.com', "123456789")
      expect(@user_logged_in).to_not eq(nil)
    end

    it 'should successfully authenticate user if there are white spaces in email' do
      @user = User.new(first_name: 'Bryan', last_name: 'Cranston', email: 'bryan@gmail.com', password: "123456789", password_confirmation: "123456789")
      @user.save
      @user_logged_in = User.authenticate_with_credentials(' bryan@gmail.com ', "123456789")
      expect(@user_logged_in).to_not eq(nil)
    end

    it 'should successfully authenticate user if email is entered in  caps' do
      @user = User.new(first_name: 'Bryan', last_name: 'Cranston', email: 'bryan@gmail.com', password: "123456789", password_confirmation: "123456789")
      @user.save
      @user_logged_in = User.authenticate_with_credentials('BRYAN@gmail.com', "123456789")
      expect(@user_logged_in).to_not eq(nil)
    end

  end


end
