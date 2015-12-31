class Award < ActiveRecord::Base
    has_many :awardings
    has_many :recipients, through: :awardings
    belongs_to :group

    validates :name, presence: true
    
    validates :description, presence: true,
        length: { minimum: 30 }

    validates :precedence, numericality: { only_integer: true }

    def to_s
      name
    end
end
