require_relative 'test_helper'

describe "you can create a Reservation instance" do
  it "can be created" do
    @new_reservation = Hotel::Reservation.new('2001-02-03', Date.today)
    expect (@new_reservation).must_be_instance_of Hotel::Reservation
  end

  describe "exception thrower" do
    it "raises an ArgumentError if the end date is before the start date" do
      expect Hotel::Reservation.new(Date.today, '2001-02-03').must_raise ArgumentError
    end
    it "raises and ArgumentError if given an invalid date" do
      expect Hotel::Reservation.new(2001-02-33, Date.today).must_raise ArgumentError
    end
  end
end

describe "you can see a list of available rooms before any reservations" do
  before do
    @new_reservation = Hotel::Reservation.new('2001-02-03', Date.today)
  end
  it "outputs list of room numbers when prompted" do
    expect(@new_reservation.available_rooms).must_be_kind_of Array
    expect(@new_reservation.available_rooms.length).must_equal 20
    expect(@new_reservation.available_rooms[0]).must_equal 1
    expect(@new_reservation.available_rooms[19]).must_equal 20
  end
end