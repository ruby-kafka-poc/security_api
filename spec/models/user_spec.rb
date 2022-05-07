# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new }

  it 'is valid with valid attributes' do
    user.assign_attributes(email: 'an@email.com', password: 'Asd')
    expect(user.errors.full_messages).to eq([])
    expect(user.valid?).to be_truthy
  end

  it 'is not valid without an email' do
    expect(user.valid?).to be_falsey
    expect(user.errors.full_messages).to include("Email can't be blank")
  end

  it 'is not valid with a wrong email' do
    user.assign_attributes(email: 'an_email.com')
    expect(user.valid?).to be_falsey
    expect(user.errors.full_messages).to include('Email is invalid')
  end
end
