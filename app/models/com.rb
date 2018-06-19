class Com < ApplicationRecord
    validates :post_id,:user_id, presence: true
    validates :content, presence: true, if: -> { image.blank? }
    validates :image, presence: true, if: -> { content.blank? }
    
    def name
        return User.find_by(id: self.user_id).name
    end
    
    def time_from_created
      y = Time.now - self.created_at
      x = y.to_i
      if x < 180
        return "now"
      elsif x < 600
        return "3 minutes"
      elsif x < 1800
        return "10 minutes"
      elsif x < 3600
        return "30 minutes"
      elsif x > 3601 && x < 24*3600
        return "#{x/3600} hours"
      elsif x < 24*3600*7
        return "#{x/(3600*24)} days"
      elsif x < 24*3600*30
        return "#{x/(3600*24*7)} weeks"
      else
        return "months ago..."
      end
    end
end
