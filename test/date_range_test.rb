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
  it 'returns true when dates overlap at end of existing date range' do
    @overlap_at_end = Hotel::DateRange.new("2019-9-8", "2019-9-12")
    expect(existing_date_range.overlap?(@overlap_at_end)).must_equal true
  end
  it 'returns true when dates overlap at beginning of existing date range' do
    @overlap_at_beg = Hotel::DateRange.new("2019-8-15", "2019-9-2")
    expect(existing_date_range.overlap?(@overlap_at_beg)).must_equal true
  end
  it 'returns true when dates overlap exactly' do
    @overlap_exactly = Hotel::DateRange.new("2019-9-1", "2019-9-10")
    expect(existing_date_range.overlap?(@overlap_exactly)).must_equal true
  end
  it 'returns true when start dates are the same' do
    @same_start_dates = Hotel::DateRange.new('2019-9-1', '2020-2-1')
    expect(existing_date_range.overlap?(@same_start_dates)).must_equal true
  end
  it 'returns true when end dates are the same' do
    @same_end_dates = Hotel::DateRange.new('2018-12-25', '2019-9-10')
    expect(existing_date_range.overlap?(@same_end_dates)).must_equal true
  end
  it 'returns true when other date range is completely contained by existing date range' do
    @consumed_date_range = Hotel::DateRange.new('2019-9-5', '2019-9-7')
    expect(existing_date_range.overlap?(@consumed_date_range)).must_equal true
  end
  it 'returns true when existing date range is completely contained by other date range' do
    @consuming_date_range = Hotel::DateRange.new('2019-8-20', '2019-9-29')
    expect(existing_date_range.overlap?(@consuming_date_range)).must_equal true
  end
  it 'returns false for a non-overlapping (earlier) date range' do
    @ancient_history = Hotel::DateRange.new('1979-11-9', '1979-11-11')
    expect(existing_date_range.overlap?(@ancient_history)).must_equal false
  end
  it 'returns false for a non-overlapping (later) date range' do
    @far_future = Hotel::DateRange.new('2025-1-2', '2025-1-7')
    expect(existing_date_range.overlap?(@far_future)).must_equal false
  end
  it "returns false for an end (checkout) date that is the same as an existing range's start (check-in)date" do
    @bad_day_for_housekeeping = Hotel::DateRange.new('2019-8-25', '2019-9-1')
    expect(existing_date_range.overlap?(@bad_day_for_housekeeping)).must_equal false
  end
  it "returns false for a start (check-in) date that is the same as an existing range's end (checkout) date" do
    @bad_day_for_housekeeping = Hotel::DateRange.new('2019-9-10', '2019-9-19')
    expect(existing_date_range.overlap?(@bad_day_for_housekeeping)).must_equal false
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