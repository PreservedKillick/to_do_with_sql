require 'spec_helper'

describe Task do
  it 'should initialize with a description and a list_id number' do
    test_task = Task.new('Sweep', 1)
    test_task.should be_an_instance_of Task
  end
  it 'tells you its description and list list_id' do
    test_task = Task.new('Sweep', 1)
    test_task.list_id.should eq 1
    test_task.description.should eq 'Sweep'
  end
  it "starts with no tasks" do
    test_task = Task.new('Sweep', 1)
    Task.all.should eq []
  end
  it 'lets you save tasks to the database' do
    test_task = Task.new('Sweep', 1)
    test_task.save
    Task.all.should eq [test_task]
  end
end
