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
    expect(room.is_available_on_date?('2019-02-03')).must_equal false
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
  

