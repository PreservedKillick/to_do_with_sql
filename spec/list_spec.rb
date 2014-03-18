require 'spec_helper'
require 'list'

describe 'lists' do
  it 'should initializes with a name' do
    test_list = List.new('shopping')
    test_list.should be_an_instance_of List
  end
  it "tells you its name" do
    test_list = List.new('shopping')
    test_list.name.should eq 'shopping'
  end
  it 'is created with an empty array' do
    test_list = List.new('shopping')
    List.all.should eq []
  end
  it 'sets its ID when you save it' do
    test_list = List.new('shopping')
    test_list.save
    test_list.id.should be_an_instance_of Fixnum
    List.all.should eq [test_list]
  end
  describe '.create' do
    it 'should create an instance of a list that saves automatically' do
      test_list = List.create('shopping')
      List.all.should eq [test_list]
    end
  end
end
