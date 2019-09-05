require_relative 'test_helper'

describe 'you can create a Hotel instance' do
  it 'can be created' do
    expect(Hotel::Hotel::new(20)).must_be_instance_of Hotel::Hotel
  end
end

describe 'make_rooms_array' do
  let (:new_hotel) {
    Hotel::Hotel::new(20)
  }
  it 'makes an array of specified no. of rooms' do
    expect(make_rooms_array.length).must_equal 20
  end
    it 'is an array that contains Room instances' do
    expect(@all_rooms[10]).must_be_instance_of Hotel::Room
    expect(@all_rooms.last).must_be_instance_of Hotel::Room
  end
end

describe 'make_reservation' do
  it "can be created" do
    @new_reservation = Hotel::Hotel.make_reservation('2001-02-03', '2001-02-06')
    expect (@new_reservation).must_be_kind_of Boolean
  end
end

describe "exception thrower" do
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

