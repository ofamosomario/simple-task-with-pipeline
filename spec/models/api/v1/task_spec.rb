require 'rails_helper'

RSpec.describe Api::V1::Task, type: :model do
  describe 'Validations' do
    it 'is valid with valid attributes' do
      task = described_class.new(name: 'Test Task', finished: false)
      expect(task).to be_valid
    end

    it 'is invalid without a name' do
      task = described_class.new(name: nil, finished: false)
      expect(task).not_to be_valid
      expect(task.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without a finished status' do
      task = described_class.new(name: 'Test Task', finished: nil)
      expect(task).not_to be_valid
      expect(task.errors[:finished]).to include('is not included in the list')
    end

    it 'is invalid with a finished status other than true or false' do
      task = described_class.new(name: 'Test Task', finished: nil)
      expect(task).not_to be_valid
      expect(task.errors[:finished]).to include('is not included in the list')
    end
  end

  describe 'Attributes' do
    it 'has a name' do
      task = described_class.new(name: 'Sample Task')
      expect(task.name).to eq('Sample Task')
    end

    it 'has a finished status' do
      task = described_class.new(finished: true)
      expect(task.finished).to be true
    end
  end
end
