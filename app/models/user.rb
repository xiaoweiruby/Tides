class User < ActiveRecord::Base

    belongs_to :group
    has_many :sessions, dependent: :destroy
    has_many :articles, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :images, dependent: :destroy

    validates :name, uniqueness: { message: "名字已经被使用"}
    validates :email, uniqueness: { message: "邮箱已经被使用"}
    validates :telphone, uniqueness: { message: "手机号已经被使用"}
    #validates :username, uniqueness: { message: "这个用户名已经被使用"}
    validates :password, confirmation: { message: "两次输入的密码不相同"}
    validates :password_confirmation, presence: { message: "重复的密码不能为空"}

    def User.authenticate( name, password )

        return unless user = User.find_by(name: name) || User.find_by(email: name)|| User.find_by(telphone: name)
        return unless password == user.password
        return user

    end


    def User.authenticate_token( user_id, token )
        begin
            return unless user = User.find( user_id )
            return unless user.sessions.find_by token: token, active:0
            #ip\browser\language\size\storage\
            return user
        rescue
            return nil
        end

    end

    def is_super_admin
        return self.group_id == 1? true : false
    end

end
