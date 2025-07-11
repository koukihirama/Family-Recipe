class Family < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :recipes
  has_many :members, dependent: :destroy

  before_create :generate_code
  before_create :assign_random_shared_name

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :shared_name, presence: true, uniqueness: true

  private

  def generate_code
    self.code ||= SecureRandom.urlsafe_base64(10)
  end

  def assign_random_shared_name
    self.shared_name ||= generate_shared_name
  end

  def generate_shared_name
  loop do
    name = "#{adjectives.sample}#{nouns.sample}"
    break name unless Family.exists?(shared_name: name)
  end
end
end
