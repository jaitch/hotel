require_relative 'test_helper'




describe 'duration calculator' do
  before do
    @new_reservation = Hotel::Reservation.new(2019-9-01, 2019-9-10)
  end
  it 'can calculate correct number of days given start date and end date' do
    expect(@new_reservation.duration).must_equal 9
  end
end
