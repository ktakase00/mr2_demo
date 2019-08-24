class SessionForm
  include ActiveModel::Model

  attr_accessor :user_cd

  validates :user_cd, presence: true
end
