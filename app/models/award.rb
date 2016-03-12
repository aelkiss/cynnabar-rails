class Award < ActiveRecord::Base
    has_many :awardings
    has_many :recipients, through: :awardings
    belongs_to :group

    has_attached_file :heraldry
    validates_with AttachmentContentTypeValidator, attributes: :heraldry, content_type: /\Aimage\/.*\Z/
    validates_with AttachmentSizeValidator, attributes: :heraldry, less_than: 500.kilobytes

    validates :name, presence: true
    
    validates :description, presence: true,
        length: { minimum: 30 }

    validates :precedence, presence: true

    has_many :awardings
    has_many :awards, through: :awardings

    def to_s
      name
    end
end
