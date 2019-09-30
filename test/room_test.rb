require_relative 'test_helper'

describe 'initiate' do
  it 'makes new instance of Room' do
    expect(Hotel::Room.new('test')).must_be_instance_of Hotel::Room
  end
end

describe 'is_available_on_date?' do
  it 'returns true if no existing reservations' do
    room = Hotel::Room.new(1)
    expect(room.is_available_on_date?('2019-1-1')).must_equal true
  end
  it 'returns false if room taken on that date' do
    room = Hotel::Room.new(1)
    date_range = Hotel::DateRange.new('2019-02-01', '2019-02-07')
    room.occupied_date_ranges << date_range
    expect(room.is_available_on_date?(Date.parse('2019-02-03'))).must_equal false
  end
end

describe 'is_within_a_block?' do
  it 'returns true if it is within a block' do
    room = Hotel::Room.new(1)
    date_range = Hotel::DateRange.new('2019-02-01', '2019-02-07')
    room.blocks << date_range
    expect(room.is_within_a_block?('2019-02-03')).must_equal true
  end
  it 'returns false if it is not within a block' do
    room = Hotel::Room.new(1)
    date_range = Hotel::DateRange.new('2019-02-01', '2019-02-07')
    room.blocks << date_range
    expect(room.is_within_a_block?('2019-02-09')).must_equal false
  end
end

describe 'is_available_for_date_range?' do
  it 'returns true if there are no overlapping date ranges' do
    room = Hotel::Room.new(1)
    date_range = Hotel::DateRange.new('2019-1-1', '2019-1-5')
    expect(room.is_available_for_date_range?(date_range)).must_equal true
  end
  it 'returns false if there is an overlapping date range in occupied_date_ranges' do
    room = Hotel::Room.new(1)
    date_range = Hotel::DateRange.new('2019-02-01', '2019-02-07')
    second_date_range = Hotel::DateRange.new('2019-2-3', '2019-2-10')
    room.occupied_date_ranges << date_range
    expect(room.is_available_for_date_range?(second_date_range)).must_equal false
  end
  it 'returns false if there is an overlapping date range in blocks' do
    room = Hotel::Room.new(1)
    date_range = Hotel::DateRange.new('2019-02-01', '2019-02-07')
    second_date_range = Hotel::DateRange.new('2019-2-3', '2019-2-10')
    room.blocks << date_range
    expect(room.is_available_for_date_range?(second_date_range)).must_equal false
  end
end


