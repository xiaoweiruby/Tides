class Article < ActiveRecord::Base
    belongs_to :user
    belongs_to :category
    has_many :comments, dependent: :destroy
    #validates :title, uniqueness: { message: "系统里已经有了一篇同样标题的文章了，换个标题吧。"}

    paginates_per 9

end
