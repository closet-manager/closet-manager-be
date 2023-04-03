require 'rails_helper'

describe UserMailer do 
  describe '#list_creation_email' do
    before :each do
      @user = create(:user)
      @list = List.create(name: "Cabo Trip", user_id: @user.id)
      @mail = UserMailer.with(user: @user, list: @list).list_creation_email
    end
    
    it 'renders the subject' do 
      expect(@mail.subject).to eq('You Have Created a List!')
    end

    it 'renders the receiver email' do
      expect(@mail.to).to eq([@user.email])
    end

    it 'renders the sender email' do
      expect(@mail.from).to eq(['closetcollection.turing@gmail.com'])
    end

    it 'contains the user first name in the body' do
      expect(@mail.body.encoded).to match(@user.first_name)
    end

    it 'contains the list name in the body' do
      expect(@mail.body.encoded).to match(@list.name)
    end
  end
end