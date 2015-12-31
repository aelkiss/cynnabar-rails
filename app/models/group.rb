class Group < ActiveRecord::Base
    validates :name, presence: true

    def to_s
      return name
    end
end
