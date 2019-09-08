require_relative 'test_helper'

describe 'you can create a Hotel instance' do
  it 'can be created' do
    expect(Hotel::Hotel::new(20)).must_be_instance_of Hotel::Hotel
  end
end

describe 'make_rooms_array' do
  let (:new_hotel) {
    Hotel::Hotel.new(20)
  }
  it 'makes an array of specified no. of rooms' do
    expect(new_hotel.all_rooms.length).must_equal 20
  end
  it 'makes an array that contains instances of Room' do
    (new_hotel.all_rooms.last).must_be_instance_of Hotel::Room
  end
end

describe 'list_rooms' do
  let (:new_hotel) {
    Hotel::Hotel.new(20)
  }
  it 'can list rooms by number' do
    expect(new_hotel.list_rooms(new_hotel.all_rooms)).must_be_kind_of Array
  end
end

describe 'make_reservation' do
  let (:hotel) {
    @new_hotel = Hotel::Hotel.new(5)
  }
  it "makes a successful reservation and returns amount due" do
    expect(hotel.make_reservation('2001-02-03', '2001-02-06')).must_include "Reservation booked. Amount due: $600."
  end
  
  it 'will skip over rooms if they are occupied for the given date' do
    hotel.make_reservation('2019-2-2', '2019-2-5')
    hotel.make_reservation('2019-2-2', '2019-2-5')
    hotel.make_reservation('2019-2-2', '2019-2-5')
    expect(hotel.all_rooms[0].occupied_date_ranges.length).must_equal 1
    expect(hotel.all_rooms[1].occupied_date_ranges.length).must_equal 1
    expect(hotel.all_rooms[2].occupied_date_ranges.length).must_equal 1
    expect(hotel.all_rooms[3].occupied_date_ranges.length).must_equal 0
  end
  it "returns apology msg instead of making the reservation if there are no available rooms" do
    hotel.make_reservation('2019-2-2', '2019-2-5')
    (hotel.make_reservation('2019-2-2', '2019-2-5'))
    (hotel.make_reservation('2019-2-2', '2019-2-5'))
    (hotel.make_reservation('2019-2-2', '2019-2-5'))
    (hotel.make_reservation('2019-2-2', '2019-2-5'))
    (hotel.make_reservation('2019-2-2', '2019-2-5'))
    (hotel.make_reservation('2019-2-2', '2019-2-5'))
    
    expect(hotel.make_reservation('2019-2-2', '2019-2-5')).must_include "Sorry. No available rooms for that date."
  end
end

describe 'exception thrower' do
  it "raises an ArgumentError if the end date is before the start date" do
    expect {Hotel::Hotel.new'2001-02-04', '2001-02-03'}.must_raise ArgumentError
  end
  it "raises an ArgumentError if given an invalid start date" do
    expect {Hotel::Hotel.new'2001-02-33', '2001-03-01'}.must_raise ArgumentError
  end
  it "raises an ArgumentError if given an invalid end date" do
    expect {Hotel::Hotel.new'2001-03-14', '2001-02-29'}.must_raise ArgumentError
  end
end

describe 'available_rooms_given_date' do
  let (:hotel) {
    @new_hotel = Hotel::Hotel.new(5)
  }
  it 'lists available rooms (by room number) given a date' do
    hotel.make_reservation('2019-2-2', '2019-2-5')
    hotel.make_reservation('2019-2-2', '2019-2-5')
    hotel.make_reservation('2019-2-2', '2019-2-5')
    hotel.available_rooms_given_date('2019-2-6')
    expect(hotel.available_rooms_given_date('2019-2-6')).must_be_instance_of Array
    expect(hotel.available_rooms_given_date('2019-2-6').length).must_equal 5
    expect(hotel.available_rooms_given_date('2019-2-4').length).must_equal 2
  end
  it "doesn't include a room number more than once for a date" do
    hotel.make_reservation('2019-2-2', '2019-2-5')
    hotel.make_reservation('2019-2-2', '2019-2-5')
    hotel.make_reservation('2019-2-2', '2019-2-5')
    hotel.make_reservation('2019-2-2', '2019-2-5')
    hotel.make_reservation('2019-2-2', '2019-2-5')
    hotel.make_reservation('2019-3-2', '2019-3-5')hotel.make_reservation('2019-4-2', '2019-4-5')
    expect(hotel.available_rooms_given_date('2001-2-3').length).must_equal 5
  end
end

describe 'booked_reservations' do
  it 'lists booked reservations for a given date' do
  end
end
