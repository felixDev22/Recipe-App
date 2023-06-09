require 'rails_helper'

RSpec.describe Food, type: :model do
  subject do
    @user = User.create(name: 'Epaltechs', email: 'epal@mail.com', password: 'password')
    Food.create(name: 'Corn', Measurement_unit: 'grams', price: 2, user: @user)
  end

  before(:each) { subject.save }

  it 'should have name corn' do
    expect(subject.name).to eql('Corn')
  end

  it 'should have Measurement unit grams' do
    expect(subject.Measurement_unit).to eql('grams')
  end

  it 'Should always have Measurement unit present' do
    subject.Measurement_unit = nil
    expect(subject).to_not be_valid
  end

  it 'should have price of 2' do
    expect(subject.price).to eql(2)
  end

  it 'Should always have Price present' do
    subject.price = nil
    expect(subject).to_not be_valid
  end

  it 'Price should be greater than or equal to 0' do
    subject.price = -1
    expect(subject).to_not be_valid
  end

  it 'Price should be an integer' do
    subject.price = 'string'
    expect(subject).to_not be_valid
  end
end
