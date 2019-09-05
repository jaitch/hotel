require_relative 'test_helper'

describe 'initiate' do
  it 'makes new instance of Room' do
    expect(Hotel::Room.new('test')).must_be_instance_of Hotel::Room
  end
end


