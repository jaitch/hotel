require_relative 'test_helper'

require_relative 'test_helper'

describe 'you can create a Reservation instance' do
  it 'can be created' do
    date_range = Hotel::DateRange.new('2019-1-2', '2019-2-3')
    expect(Hotel::Reservation.new(date_range)).must_be_instance_of Hotel::Reservation
  end
end

describe "Reservation can be made by 'make reservation' method" do
  it 'can be created' do
    date_range = Hotel::DateRange.new('2019-1-2', '2019-2-3')
    front_desk = Hotel::FrontDesk.new(3)
    expect(front_desk.make_reservation(date_range)).must_include "Reservation booked."
  end
end

describe "Reservation can be made by 'book room in an existing block' method" do
  it 'can be created' do
    hotel = Hotel::FrontDesk.new(3)
    date_range = Hotel::DateRange.new('2019-10-1', '2019-10-15')
    hotel.make_room_block(3, date_range)
    expect(hotel.book_a_room_in_an_existing_block(2, date_range)).must_include "Amount due: $2240."
  end
end