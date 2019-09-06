require_relative 'test_helper'

describe 'duration calculator' do
  it 'can calculate correct number of days given start date and end date' do
    @new_dates = Hotel::DateRange.new("2019-9-01", "2019-9-10")
    expect(@new_dates.duration).must_equal 9
  end
  it 'can caluclate correct number of days when start and end dates are in different months' do
    @new_dates = Hotel::DateRange.new("2019-8-29", "2019-9-01")
    expect(@new_dates.duration).must_equal 3
  end
end

describe 'overlap?' do
  let (:existing_date_range) {
    @new_dates = Hotel::DateRange.new("2019-9-01", "2019-9-10")
  }
  it 'returns false when dates overlap at end of existing date range' do
    @overlap_at_end = Hotel::DateRange.new("2019-9-8", "2019-9-12")
    expect(existing_date_range.overlap?(@overlap_at_end)).must_equal false
  end
  it 'returns false when dates overlap at beginning of existing date range' do
    @overlap_at_beg = Hotel::DateRange.new("2019-8-15", "2019-9-2")
    expect(existing_date_range.overlap?(@overlap_at_beg)).must_equal false
  end
  it 'returns false when dates overlap exactly' do
    @overlap_exactly = Hotel::DateRange.new("2019-9-1", "2019-9-10")
    expect(existing_date_range.overlap?(@overlap_exactly)).must_equal false
  end
  it 'returns false when start dates are the same' do
    @same_start_dates = Hotel::DateRange.new('2019-9-1', '2020-2-1')
    expect(existing_date_range.overlap?(@same_start_dates)).must_equal false
  end
  it 'returns false when end dates are the same' do
    @same_end_dates = Hotel::DateRange.new('2018-12-25', '2019-9-10')
    expect(existing_date_range.overlap?(@same_end_dates)).must_equal false
  end
end


# describe "available_rooms" do
#   it "outputs list of room numbers when prompted" do
#     expect(@new_reservation.available_rooms).must_be_kind_of Array
#     expect(@new_reservation.available_rooms.length).must_equal 20
#     expect(@new_reservation.available_rooms[0]).must_equal 1
#     expect(@new_reservation.available_rooms[19]).must_equal 20
#   end
# end

# describe 'reservations by date' do
#   let (:new_dates) {
#     Hotel::DateRange.new("2019-8-29", "2019-9-01")
#     Hotel::DateRange.new("2019-8-31", "2019-9-3")
#     it 'returns occupied rooms for given date' do
#       new_dates.reservation_by_date("2019-8-29")
#     end
#     it 'returns vacant rooms for given date' do
#     end
#   end
# end