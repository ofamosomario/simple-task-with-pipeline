module Api
  module V1
    class Task < ApplicationRecord
      validates :name, presence: true
      validates :finished, inclusion: { in: [true, false] }
    end
  end
end
