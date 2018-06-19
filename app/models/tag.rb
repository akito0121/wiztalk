class Tag < ApplicationRecord
    validates :name,uniqueness: true ,presence: true,length: { minimum: 2 ,maximum: 10 }
    
    def count
        return Category.where(name: self.name).count
    end
end
