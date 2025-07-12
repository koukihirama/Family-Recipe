class Family < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :recipes
  has_many :members, dependent: :destroy

  before_validation :generate_code, on: :create
  before_validation :assign_random_shared_name, on: :create

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
    adjectives = %w[ほのぼの にぎやか やさしい しあわせ]
    nouns = %w[家族 キッチン 食卓 ごはん 料理団]

    10.times do
      name = "#{adjectives.sample}#{nouns.sample}"
      return name unless Family.exists?(shared_name: name)
    end

    "ななしの家族#{SecureRandom.hex(2)}"
  end
end