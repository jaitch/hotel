require_relative 'test_helper'

require_relative 'test_helper'

describe 'you can create a Reservation instance' do
  it 'can be created' do
    date_range = Hotel::DateRange.new('2019-1-2', '2019-2-3')
    expect(Hotel::Reservation.new(date_range)).must_be_instance_of Hotel::Reservation
  end
end