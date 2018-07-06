class Visitor
  include Mongoid::Document
  include Mongoid::Timestamps

  field :first_name, type: String
  field :last_name, type: String
  field :s_id, type: String
  field :profile_url, type: String
  field :gender, type: String
  field :messages, type: Array, default: []

  validates :first_name, :last_name, :s_id, presence: true
  validates :s_id, uniqueness: true
end
