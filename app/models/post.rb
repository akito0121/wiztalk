class Post < ApplicationRecord
    
    validate :add_error_sample

  def add_error_sample
    if title.blank?
      errors[:base] << "タイトルを入力してください"
    end
    if content.blank?
      errors[:base] << "投稿内容を入力してください"
    end
  end

    belongs_to :user
    
   # paginates_per 10
    
    def like_count
        return Like.where(post_id: self.id).count
    end
    
#has_many,belongs_toを使うことで、同じことができる！
    def post_user
        return User.find_by(id: self.user_id)
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
