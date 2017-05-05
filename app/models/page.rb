class Page < ApplicationRecord
  has_many :tags

  validates :url, presence: true, uniqueness: true
end
