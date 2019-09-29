require_relative 'test_helper'

describe 'you can create a FrontDesk instance' do
  let (:new_hotel) {
    Hotel::FrontDesk.new(20)
  }
  it 'can be created' do
    expect(Hotel::FrontDesk::new(20)).must_be_instance_of Hotel::FrontDesk
  end
  it 'makes an array of specified no. of rooms' do
    expect(new_hotel.all_rooms.length).must_equal 20
  end
  it 'makes an array that contains instances of Room' do
    (new_hotel.all_rooms.last).must_be_instance_of Hotel::Room
  end
end

describe 'list_rooms' do
  let (:hotel) {
    Hotel::FrontDesk.new(20)
  }
  it 'can list rooms by number' do
    expect(hotel.list_rooms(hotel.all_rooms)).must_be_kind_of Array
  end
end

describe 'make_reservation' do
  let (:hotel) {
    Hotel::FrontDesk.new(5)
  }
  it "makes a successful reservation and returns amount due" do
    possible_date_range = Hotel::DateRange.new('2019-2-2', '2019-2-5')
    expect(hotel.make_reservation(possible_date_range)).must_include "Reservation booked. Amount due: $600."
  end
  it 'will add date ranges to the occupied date ranges list as a reservation is made. it will also skip over rooms if they are occupied for the given date' do
    possible_date_range = Hotel::DateRange.new('2019-2-2', '2019-2-5')
    hotel.make_reservation(possible_date_range)
    hotel.make_reservation(possible_date_range)
    hotel.make_reservation(possible_date_range)
    expect(hotel.all_rooms[0].occupied_date_ranges.length).must_equal 1
    expect(hotel.all_rooms[1].occupied_date_ranges.length).must_equal 1
    expect(hotel.all_rooms[2].occupied_date_ranges.length).must_equal 1
    expect(hotel.all_rooms[3].occupied_date_ranges.length).must_equal 0
  end
  it "raises an error instead of making the reservation if there are no available rooms" do
    possible_date_range = Hotel::DateRange.new('2019-2-2', '2019-2-5')
    hotel.make_reservation(possible_date_range)
    hotel.make_reservation(possible_date_range)
    hotel.make_reservation(possible_date_range)
    hotel.make_reservation(possible_date_range)
    hotel.make_reservation(possible_date_range)
    expect {hotel.make_reservation(possible_date_range)}.must_raise ArgumentError
  end
end

describe 'make_room_block' do
  let (:hotel) {
    Hotel::FrontDesk.new(6)
  }
  it 'apologizes if asked for more than five rooms' do
    date_range = Hotel::DateRange.new('2019-10-1', '2019-10-15')
    expect(hotel.make_room_block(6, date_range)).must_include "Sorry"
  end
  it 'adds the block dates to the block array within Room' do
    date_range = Hotel::DateRange.new('2019-10-1', '2019-10-15')
    hotel.make_room_block(3, date_range)
    expect(hotel.all_rooms[0].blocks.length).must_equal 1
  end
  it "protests if there aren't enough rooms available for the block requested" do
    date_range = Hotel::DateRange.new('2019-2-2', '2019-2-5')
    failing_date_range = Hotel::DateRange.new('2019-2-1', '2019-2-10')
    hotel.make_reservation(date_range)
    hotel.make_reservation(date_range)
    expect {hotel.make_room_block(5, failing_date_range)}.must_raise ArgumentError
  end
  it "doesn't allow overlapping blocks to be made" do
    date_range = Hotel::DateRange.new('2019-2-1', '2019-2-10')
    failing_date_range = Hotel::DateRange.new('2019-2-3', '2019-2-18')
    hotel.make_room_block(5, date_range)
    expect {hotel.make_room_block(5, failing_date_range)}.must_raise ArgumentError
  end
  it 'does not allow the rooms and dates set aside for the block to be reserved by regular means' do
    date_range = Hotel::DateRange.new('2019-2-1', '2019-2-10')
    hotel.make_room_block(5, date_range)
    hotel.make_reservation(date_range)
    expect {hotel.make_reservation(date_range)}.must_raise ArgumentError
  end
end

describe 'book_a_room_in_an_existing_block' do
  let (:hotel) {
    Hotel::FrontDesk.new(6)
  }
  it 'enables rooms within a block to be booked individually by room number, and that reservation duration is in keeping with the block duration. provides a discounted rate' do
    date_range = Hotel::DateRange.new('2019-10-1', '2019-10-15')
    hotel.make_room_block(3, date_range)
    expect(hotel.book_a_room_in_an_existing_block(2, date_range)).must_include "Amount due: $2240."
  end
  it 'does not allow a particular room in a block to be booked more than once' do
    date_range = Hotel::DateRange.new('2019-2-1', '2019-2-10')
    hotel.make_room_block(5, date_range)
    hotel.book_a_room_in_an_existing_block(1, date_range)
    expect(hotel.book_a_room_in_an_existing_block(1, date_range)).must_include "Sorry."
  end
  it 'must provide same dates of an existing block to book one of those rooms to reserve room' do
    date_range = Hotel::DateRange.new('2019-2-1', '2019-2-10')
    failing_date_range = Hotel::DateRange.new('2019-2-1', '2019-2-11')
    hotel.make_room_block(5, date_range)
    expect(hotel.book_a_room_in_an_existing_block(1, failing_date_range)).must_include "Sorry."
  end
end

describe 'rooms_available_in_an_existing_block' do
  let (:hotel) {
    Hotel::FrontDesk.new(6)
  }
  it 'can check the block for room availability' do
    date_range = Hotel::DateRange.new('2019-2-1', '2019-2-10')
    hotel.make_room_block(5, date_range)
    hotel.book_a_room_in_an_existing_block(3, date_range)
    expect(hotel.rooms_available_in_an_existing_block(date_range)).must_be_instance_of Array
    expect(hotel.rooms_available_in_an_existing_block(date_range)).must_equal [1, 2, 4, 5]
  end
end

describe 'exception thrower' do
  it "raises an ArgumentError if the end date is before the start date" do
    expect {Hotel::FrontDesk.new'2001-02-04', '2001-02-03'}.must_raise ArgumentError
  end
  it "raises an ArgumentError if given an invalid start date" do
    expect {Hotel::FrontDesk.new'2001-02-33', '2001-03-01'}.must_raise ArgumentError
  end
  it "raises an ArgumentError if given an invalid end date" do
    expect {Hotel::FrontDesk.new'2001-03-14', '2001-02-29'}.must_raise ArgumentError
  end
end

describe 'available_rooms_given_date' do
  let (:hotel) {
    Hotel::FrontDesk.new(5)
  }
  it 'lists available rooms (by room number) given a date' do
    date_range = Hotel::DateRange.new('2019-2-2', '2019-2-5')
    hotel.make_reservation(date_range)
    hotel.make_reservation(date_range)
    hotel.make_reservation(date_range)
    expect(hotel.available_rooms_given_date('2019-2-6')).must_be_instance_of Array
    expect(hotel.available_rooms_given_date('2019-2-6').length).must_equal 5
    expect(hotel.available_rooms_given_date('2019-2-4').length).must_equal 2
  end
  it "doesn't include a room number more than once for a date" do
    date_range = Hotel::DateRange.new('2019-2-2', '2019-2-5')
    second_date_range = Hotel::DateRange.new('2019-3-2', '2019-3-5')
    third_date_range = Hotel::DateRange.new('2019-4-2', '2019-4-5')
    hotel.make_reservation(date_range)
    hotel.make_reservation(date_range)
    hotel.make_reservation(date_range)
    hotel.make_reservation(date_range)
    hotel.make_reservation(date_range)
    hotel.make_reservation(second_date_range)
    hotel.make_reservation(third_date_range)
    expect(hotel.available_rooms_given_date('2001-2-3').length).must_equal 5
  end
  it 'if a room has an end date equal to the queried date, it IS included in the available rooms' do
    date_range = Hotel::DateRange.new('2019-2-5', '2019-2-15')
    hotel.make_reservation(date_range)
    expect(hotel.available_rooms_given_date('2019-2-15').length).must_equal 5
  end
  it 'if a room has a start date equal to the queried date, it IS NOT included in the available rooms' do
    date_range = Hotel::DateRange.new('2019-2-2', '2019-2-6')
    hotel.make_reservation(date_range)
    expect(hotel.available_rooms_given_date('2019-2-2').length).must_equal 4
  end
  it 'does not include rooms set aside in blocks in the available rooms' do
    first_date_range = Hotel::DateRange.new('2019-3-2', '2019-3-5')
    second_date_range = Hotel::DateRange.new('2019-3-1', '2019-3-10')
    hotel.make_reservation(first_date_range)
    hotel.make_room_block(3, second_date_range)
    expect(hotel.available_rooms_given_date('2019-3-3').length).must_equal 1
  end
end

describe 'available_rooms_given_date_range' do
  let (:hotel) {
    Hotel::FrontDesk.new(5)
  }
  it 'returns a list of rooms available for an entire date range' do
    first_date_range = Hotel::DateRange.new('2019-3-10', '2019-3-30')
    second_date_range = Hotel::DateRange.new('2019-3-1', '2019-3-10')
    third_date_range = Hotel::DateRange.new('2019-3-15', '2019-4-10')
    fourth_date_range = Hotel::DateRange.new('2019-3-5', '2019-3-9')
    test_date_range = Hotel::DateRange.new('2019-3-4', '2019-3-11')
    hotel.make_reservation(first_date_range)
    hotel.make_reservation(second_date_range)
    hotel.make_reservation(third_date_range)
    hotel.make_reservation(fourth_date_range)
    expect(hotel.available_rooms_given_date_range(test_date_range)).length.must_equal 2
  end
  it 'does not include rooms reserved in a block in rooms available' do
    first_date_range = Hotel::DateRange.new('2019-3-10', '2019-3-30')
    second_date_range = Hotel::DateRange.new('2019-3-1', '2019-3-10')
    third_date_range = Hotel::DateRange.new('2019-3-1', '2019-3-19')
    test_date_range = Hotel::DateRange.new('2019-3-2', '2019-3-13')
    hotel.make_reservation(first_date_range)
    hotel.make_reservation(second_date_range)
    hotel.make_room_block(3, third_date_range)
    expect(hotel.available_rooms_given_date_range(test_date_range).length).must_equal 1
  end
end

describe 'list_reservations_given_date' do
  let (:hotel) {
    Hotel::FrontDesk.new(3)
  }
  it 'returns array of room #s with reservations occupying a given date' do
  first_date_range = Hotel::DateRange.new('2019-2-2', '2019-2-5')
  second_date_range = Hotel::DateRange.new('2019-2-1', '2019-2-6')
  third_date_range = Hotel::DateRange.new('2019-2-3', '2019-2-7')
  fourth_date_range = Hotel::DateRange.new('2019-3-1', '2019-3-7')
  fifth_date_range = Hotel::DateRange.new('2019-3-5', '2019-3-6')
    hotel.make_reservation(first_date_range)
    hotel.make_reservation(second_date_range)
    hotel.make_reservation(third_date_range)
    hotel.make_reservation(fourth_date_range)
    hotel.make_reservation(fifth_date_range)
    expect(hotel.list_reservations_given_date('2019-2-4')).must_be_kind_of Array
    expect(hotel.list_reservations_given_date('2019-3-5').length).must_equal 2
    expect(hotel.list_reservations_given_date('2019-2-4')).must_equal [1, 2, 3]
  end
end
