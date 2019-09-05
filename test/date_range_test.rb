require_relative 'test_helper'

describe 'duration calculator' do
  it 'can calculate correct number of days given start date and end date' do
    @new_dates = Hotel::Date_Range.new("2019-9-01", "2019-9-10")
    expect(@new_dates.duration).must_equal 9
  end
  it 'can caluclate correct number of days when start and end dates are in different months' do
    @new_dates = Hotel::Date_Range.new("2019-8-29", "2019-9-01")
    expect(@new_dates.duration).must_equal 3
  end
end

# describe "you can see a list of available rooms before any reservations" do
#   let (:new_reservation) {
#     Hotel::Reservation.new('2001-02-03', '2001-02-06')
#   }
#   it "outputs list of room numbers when prompted" do
#     expect(@new_reservation.available_rooms).must_be_kind_of Array
#     expect(@new_reservation.available_rooms.length).must_equal 20
#     expect(@new_reservation.available_rooms[0]).must_equal 1
#     expect(@new_reservation.available_rooms[19]).must_equal 20
#   end
# end

describe 'reservations by date' do
  it 'returns occupied rooms for given date' do
  end
  it 'returns vacant rooms for given date' do
  end
end