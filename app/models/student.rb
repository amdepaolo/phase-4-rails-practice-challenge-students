class Student < ApplicationRecord
    validates :name, presence: true
    validates :age, numericality: {greater_than: 17}
    belongs_to :instructor

    private
end
