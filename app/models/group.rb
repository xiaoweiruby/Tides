class Group < ActiveRecord::Base
    has_many :users, dependent: :destroy
end
