require 'rails_helper'

describe UserMailer do 
  describe '#list_creation_email' do 
    it 'renders the subject' do 
      user = create(:user)
      mail = UserMailer.with(user: user).list_creation_email

      expect(mail.subject).to eq('You Have Created a List!')
    end

    it 'renders the receiver email' do
      user = create(:user)
      mail = UserMailer.with(user: user).list_creation_email

      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      user = create(:user)
      mail = UserMailer.with(user: user).list_creation_email

      expect(mail.from).to eq(['closetcollection.turing@gmail.com'])
    end

    it 'contains the user first name in the body' do
      user = create(:user)
      mail = UserMailer.with(user: user).list_creation_email

      expect(mail.body.encoded).to match(user.first_name)
    end
  end
end