require_relative 'test-helper'

describe "you can create a Reservation instance" do
  it "can be created" do
    new_reservation = Reservation.new(dateTK, dateTK)
    expect (new_reservation).must_be_instance_of Reservation
  end
end

describe "you can see a list of available rooms" do
  it "outputs list of room numbers when prompted" do
  end
  expect(available_rooms).must_be_kind_of Array
end