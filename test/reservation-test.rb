require_relative 'test-helper'

describe "you can create a Reservation instance" do
  it "can be created" do
    new_reservation = Reservation.new(dateTK, dateTK)
    expect (new_reservation).must_be_instance_of Reservation
  end
end