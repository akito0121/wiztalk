class Category < ApplicationRecord
    validates :post_id,:uniqueness => {:scope =>:name }
        
    def pos
        return Post.find_by(id: self.post_id)
    end
end
