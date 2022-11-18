# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    validates :username, :password_digest, :session_token, presence: true 
    validates :username, :session_token, uniqueness: true
    validates :password, length: {minimum: 6, allow_nil: true}
    attr_reader :password

    before_validation :ensure_session_token


    has_many :subs, 
    class_name: :Sub, 
    foreign_key: :moderator_id

    
    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        
        if user && user.is_password?(password)
            return user
        else
            return nil
        end
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        bcrypt_obj = BCrypt::Password.new(self.password_digest)
        bcrypt_obj.is_password?(password)
    end

    def reset_session_token
        self.session_token = generate_session_token
        self.save!
        self.session_token
    end

    def generate_session_token
        token = SecureRandom::urlsafe_base64
        while User.exists?(session_token: token)
            token = SecureRandom::urlsafe_base64
        end
        token
    end

    def ensure_session_token
        self.session_token ||= generate_session_token
    end
    
end
