require_relative 'test_helper'

describe "you can create a Reservation instance" do
  it "can be created" do
    @new_reservation = Hotel::Reservation.new('2001-02-03', '2001-02-06')
    expect (@new_reservation).must_be_instance_of Hotel::Reservation
  end
end

describe "exception thrower" do
  it "raises an ArgumentError if the end date is before the start date" do
    expect {Hotel::Reservation.new'2001-02-04', '2001-02-03'}.must_raise ArgumentError
  end
  it "raises an ArgumentError if given an invalid start date" do
    expect {Hotel::Reservation.new'2001-02-33', '2001-03-01'}.must_raise ArgumentError
  end
  it "raises an ArgumentError if given an invalid end date" do
    expect {Hotel::Reservation.new'2001-03-14', '2001-02-29'}.must_raise ArgumentError
  end
end
